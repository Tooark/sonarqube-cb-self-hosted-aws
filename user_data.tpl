#!/bin/bash

#Sonarqube
# Variável para a versão do SonarQube 25.3 (06/03/2025)
SONARQUBE_VERSION=${sonar_version} 
export SONARQUBE_VERSION

# Atualiza os pacotes
sudo apt-get update

# Instala o Java (SonarQube requer Java 17 ou superior)
# Algumas AMIs Debian minimal podem não trazer o pacote openjdk-17-jdk no repo principal.
# Estratégia:
# 1. Tentar openjdk-17-jdk.
# 2. Se não existir, adicionar repositório Adoptium (Temurin) e instalar temurin-17-jdk.
# 3. Como fallback final, usar default-jdk (pode ser Java 21 em versões mais novas; compatível >=17).

source /etc/os-release
sudo apt-get update
if apt-cache show openjdk-17-jdk > /dev/null 2>&1; then
  echo "[user_data] Instalando openjdk-17-jdk do repositório padrão"
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-17-jdk
elif apt-cache show default-jdk > /dev/null 2>&1 && apt-cache show default-jdk | grep -q "17"; then
  echo "[user_data] openjdk-17-jdk ausente; default-jdk aponta para Java 17"
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y default-jdk
else
  echo "[user_data] Adicionando repositório Adoptium Temurin para Java 17"
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y wget gnupg ca-certificates
  curl -fsSL https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo gpg --dearmor -o /usr/share/keyrings/adoptium.gpg
  echo "deb [signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb $VERSION_CODENAME main" | sudo tee /etc/apt/sources.list.d/adoptium.list
  sudo apt-get update
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y temurin-17-jdk || sudo DEBIAN_FRONTEND=noninteractive apt-get install -y default-jdk
fi

# Exporta JAVA_HOME dinamicamente
JAVA_BIN_PATH=$(readlink -f $(which java) 2>/dev/null || true)
if [ -n "$JAVA_BIN_PATH" ]; then
  JAVA_HOME_DIR=$(dirname $(dirname "$JAVA_BIN_PATH"))
  echo "[user_data] Detectado JAVA_HOME=$${JAVA_HOME_DIR}"
  export JAVA_HOME="$JAVA_HOME_DIR"
fi

# Instala o EC2 Instance Connect e curl
sudo apt-get install -y ec2-instance-connect curl

# Cria um diretório para o SonarQube
sudo mkdir /opt/sonarqube

# Baixa o SonarQube
curl -O https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-$${SONARQUBE_VERSION}.zip

# Instala o unzip para descompactar o SonarQube
sudo apt-get install -y unzip jq dpkg

sleep 3

# Descompacta o SonarQube
unzip sonarqube-$${SONARQUBE_VERSION}.zip -d /opt/sonarqube

# Renomeia o diretório descompactado
sudo mv /opt/sonarqube/sonarqube-$${SONARQUBE_VERSION} /opt/sonarqube/sonarqube

# Cria um usuário para o SonarQube
sudo useradd -r -m -d /opt/sonarqube/sonarqube sonarqube

# Altera a propriedade do diretório do SonarQube
sudo chown -R sonarqube:sonarqube /opt/sonarqube/sonarqube

# Configura o SonarQube para iniciar como um serviço
sudo tee /etc/systemd/system/sonarqube.service > /dev/null <<EOF
[Unit]
Description=SonarQube service
After=network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonarqube
Group=sonarqube
Restart=always
LimitNOFILE=131072
LimitNPROC=8192

[Install]
WantedBy=multi-user.target
EOF

# Recarrega o systemd para reconhecer o novo serviço
sudo systemctl daemon-reload

### Configura o arquivo sonar.properties
# Carregar variáveis de ambiente do Secrets manager

# Recuperar o segredo do Google Secret Manager
CREDS=$(aws secretsmanager get-secret-value --secret-id sonar_db_credentials --query SecretString --output text)
SONAR_DB_USER=$(echo $CREDS | jq -r .username)
SONAR_DB_PASSWORD=$(echo $CREDS | jq -r .password)
SONAR_DB_HOST=$(echo $CREDS | jq -r .host)
SONAR_DB_NAME=$(echo $CREDS | jq -r .dbname)

sleep 5

# Exportar a variável de ambiente
export SONAR_DB_USER
export SONAR_DB_PASSWORD
export SONAR_DB_HOST
export SONAR_DB_NAME

# Atualiza o sonar.properties para sobrescrever o sonar.web.context
sudo sed -i '/^#.*sonar\.web\.context/c\sonar.web.context=' /opt/sonarqube/sonarqube/conf/sonar.properties

sudo cat <<EOT >> /opt/sonarqube/sonarqube/conf/sonar.properties
sonar.jdbc.url=jdbc:postgresql://$${SONAR_DB_HOST}:5432/$${SONAR_DB_NAME}
sonar.jdbc.username=$${SONAR_DB_USER}
sonar.jdbc.password=$${SONAR_DB_PASSWORD}
EOT

# FIX Elasticsearch - persistir vm.max_map_count e aplicar
echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Habilita o serviço SonarQube para iniciar na inicialização
sudo systemctl enable sonarqube

# Reinicia o serviço SonarQube para aplicar as mudanças
sudo systemctl restart sonarqube

#Nginx
sudo apt-get install -y nginx

# Troca ips para o da vm e lb
sudo tee /etc/nginx/sites-available/sonarqube > /dev/null <<EOF
server {
  listen 80;
  server_name ${domain_name};
  
  access_log /var/log/nginx/sonarqube.access.log;
  error_log /var/log/nginx/sonarqube.error.log;
  client_max_body_size 50M;

  location / {
    proxy_pass http://localhost:9000;
    proxy_set_header Host \$host;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto \$scheme;
  }
}
EOF

sudo ln -sf /etc/nginx/sites-available/sonarqube /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

#Instalacao do cloudwatch agent(Debian)
sudo curl -sS "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_arm64/amazon-ssm-agent.deb" -o "/tmp/amazon-ssm-agent.deb"
sudo dpkg -i "/tmp/amazon-ssm-agent.deb"
sudo systemctl daemon-reload
apt show amazon-ssm-agent
sudo systemctl restart amazon-ssm-agent
sudo systemctl status -l amazon-ssm-agent

 # Configure AWS Systems Manager Agent software (Start Daemon awsagent)
if [ $(sudo systemctl is-enabled amazon-ssm-agent) = "disabled" ]; then
sudo systemctl enable amazon-ssm-agent
sudo systemctl is-enabled amazon-ssm-agent
fi