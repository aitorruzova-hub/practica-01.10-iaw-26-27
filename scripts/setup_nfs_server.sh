#!/bin/bash
set -exu

#Importamos las variables de entorno
source .env

#Actualizamos el sistema
apt update -y

# Instalamos el servidor NFS
apt install -y nfs-kernel-server

# Creamos el directorio que vamos a compartir
mkdir -p /var/www/html

# Configuramos los permisos del directorio compartido
sudo chown nobody:nogroup /var/www/html

# Configuramos el archivo de exportación de NFS
envsubst '${FRONTED_NETWORK}' < ../nfs/exports.template > /etc/exports

# Reiniciamos el servicio NFS para aplicar los cambios
systemctl restart nfs-kernel-server