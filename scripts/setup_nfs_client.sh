#!/bin/bash
set -exu

# Importamos las variables de entorno
source .env
# Actualizamos el sistema
apt update -y

# Instalamos el cliente NFS
apt install -y nfs-common

# Montamos el directorio compartido del servidor NFS en el cliente
mount ${NFS_SERVER_IP}:/var/www/html /var/www/html

# Configuramos el montaje automático del directorio compartido en el arranque del sistema
echo "${NFS_SERVER_IP}:/var/www/html /var/www/html nfs defaults 0 0" >> /etc/fstab