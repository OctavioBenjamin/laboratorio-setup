#!/bin/bash
# Script para instalar InfoStat, LibreOffice, lector de PDF y descompresor de archivos en sistemas Debian/Ubuntu

set -e

# Actualizar repositorios
sudo apt update

# Instalar Wine (para ejecutar InfoStat)
sudo apt install -y wine

# Instalar LibreOffice
sudo apt install -y libreoffice

# Instalar lector de PDF (Evince)
sudo apt install -y evince

# Instalar descompresores (p7zip y unzip)
sudo apt install -y p7zip-full unzip

# Instalar InfoStat (requiere archivo de instalación, modificar la ruta si es necesario)
INFOSTAT_INSTALLER="InfoStatSetup.exe"
if [ -f "$INFOSTAT_INSTALLER" ]; then
    wine "$INFOSTAT_INSTALLER"
else
    echo "Por favor, coloque el instalador de InfoStat ($INFOSTAT_INSTALLER) en el mismo directorio que este script."
fi

echo "Instalación completada."
