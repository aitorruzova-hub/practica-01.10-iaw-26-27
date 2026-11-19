#!/bin/bash
set -exu

#Habilitamos la exportación automática de variables de entorno
set -a

#Importamos el archivo de variables
source .env

#Actualizamos los paqeutes
apt update

#Instalamos Nginx
apt install nginx -y


# Deshabilitamos el sitio por defecto (si sigue habilitado)
if [ -L /etc/nginx/sites-enabled/default ]; then
    unlink /etc/nginx/sites-enabled/default
fi

# Reemplazamos las variables de entorno en el archivo de configuración del balanceador de carga
envsubst '${IP_FRONTEND_1} ${IP_FRONTEND_2} ${LETS_ENCRYPT_DOMAIN}' < ../conf/load_balancer.conf.template > /etc/nginx/sites-available/${LETS_ENCRYPT_DOMAIN}.conf

# Habilitamos nuestro sitio (-f sobreescribe si ya existe)
ln -sf /etc/nginx/sites-available/${LETS_ENCRYPT_DOMAIN}.conf /etc/nginx/sites-enabled/${LETS_ENCRYPT_DOMAIN}.conf

systemctl restart nginx