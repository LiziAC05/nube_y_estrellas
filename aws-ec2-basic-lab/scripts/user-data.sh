#!/bin/bash
sudo yum update -y
sudo yum install nginx unzip wget -y
# Iniciar nginx
sudo systemctl start nginx
sudo systemctl enable nginx
# Preparar directorio temporal para la plantilla
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"
# Descargar template
sudo wget https://github.com/StartBootstrap/startbootstrap-stylish-portfolio/archive/refs/heads/gh-pages.zip
# Extraer archivos
sudo unzip -q gh-pages.zip
# Verificar que exista la página principal
sudo test -f startbootstrap-stylish-portfolio-gh-pages/index.html
# Mover contenido
sudo cp -a startbootstrap-stylish-portfolio-gh-pages/. \
  /usr/share/nginx/html/
# Limpiar
sudo rm gh-pages.zip
sudo rm -rf startbootstrap-stylish-portfolio-gh-pages
# Reemplazar el título
sudo sed -i 's/Stylish Portfolio/1TEL01 Portfolio/g' /usr/share/nginx/html/index.html
# Permisos
sudo chown -R nginx:nginx /usr/share/nginx/html
find /usr/share/nginx/html -type d -exec chmod 755 {} \;
find /usr/share/nginx/html -type f -exec chmod 644 {} \;
# Reiniciar nginx
sudo nginx -t
sudo systemctl restart nginx
