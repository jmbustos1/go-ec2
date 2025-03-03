#!/bin/bash
# Actualizar paquetes
apt update -y
apt upgrade -y

# Instalar Docker
apt install -y docker.io
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# Instalar AWS CLI
apt install -y awscli

# Login en ECR (cambia <AWS_ACCOUNT_ID> y <REGION>)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com

# Descargar y ejecutar la imagen Docker del servidor TCP
docker pull <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/<REPO_NAME>:latest
docker run -d -p 8090:8080 <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/<REPO_NAME>:latest
