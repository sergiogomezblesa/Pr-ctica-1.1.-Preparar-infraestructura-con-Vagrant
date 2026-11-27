#!/usr/bin/env bash
# El script se detiene si hay errores
set -e
export DEBIAN_FRONTEND=noninteractive
echo "########################################"
echo " Aprovisionando adminpc "
echo "########################################"
apt-get update -y
apt-get install -y sudo curl nmap tcpdump wget iputils-ping
# Usuario administrador (en Debian el grupo de administradores es "sudo", no "wheel")
echo "=> Creamos usuario administrador..."
id admin_sergio >/dev/null 2>&1 || useradd -m -s /bin/bash admin_sergio
usermod -aG sudo admin_sergio
echo "admin_sergio ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/admin_sergio
chmod 440 /etc/sudoers.d/admin_sergio
# Claves SSH inyectadas por Vagrant en /tmp
echo "=> Importamos claves SSH"
mkdir -p /home/admin_sergio/.ssh
cp /tmp/id_ed25519 /home/admin_sergio/.ssh/id_ed25519
cp /tmp/id_ed25519.pub /home/admin_sergio/.ssh/id_ed25519.pub
# Por si las claves vienen de Windows con finales de línea CRLF
sed -i 's/\r$//' /home/admin_sergio/.ssh/id_ed25519 /home/admin_sergio/.ssh/id_ed25519.pub
chown -R admin_sergio:admin_sergio /home/admin_sergio/.ssh
chmod 700 /home/admin_sergio/.ssh
chmod 600 /home/admin_sergio/.ssh/id_ed25519
chmod 644 /home/admin_sergio/.ssh/id_ed25519.pub
echo "------ FIN ------"