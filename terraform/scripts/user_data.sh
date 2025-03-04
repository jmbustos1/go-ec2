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

# 🔹 Eliminar el agente SSM si ya está instalado con Snap (para evitar conflicto con dpkg)
if snap list | grep -q amazon-ssm-agent; then
    snap remove amazon-ssm-agent
fi

# 🔹 Instalar el agente AWS SSM con dpkg
cd /tmp
curl -O https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
dpkg -i amazon-ssm-agent.deb

# 🔹 Habilitar y arrancar el servicio SSM
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# 🔹 Verificar que el servicio está corriendo
systemctl status amazon-ssm-agent --no-pager
