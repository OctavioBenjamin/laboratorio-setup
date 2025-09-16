#!/bin/bash
# Script para instalar InfoStat, LibreOffice, lector de PDF y descompresor de archivos en sistemas Debian/Ubuntu

set -e

# Actualizar repositorios
sudo apt update


###########################################################
# Wine (https://wiki.winehq.org/Download)
###########################################################
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y wget gnupg2 software-properties-common
sudo mkdir -pm755 /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.ke
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources
sudo apt update
sudo apt install --install-recommends -y winehq-stable
wine --version

###########################################################
# LibreOffice (https://www.libreoffice.org/download/download/)
###########################################################
sudo apt install -y libreoffice

###########################################################
# Evince (https://wiki.gnome.org/Apps/Evince)
###########################################################
sudo apt install -y evince

###########################################################
# p7zip (https://p7zip.sourceforge.net/) y unzip (https://linux.die.net/man/1/unzip)
###########################################################
sudo apt install -y p7zip-full unzip


###########################################################
# InfoStat (https://www.infostat.com.ar/)
###########################################################
INFOSTAT_DL="$HOME/Descargas/infostatinstaller_esp.exe"
INFOSTAT_CUR="$(pwd)/infostatinstaller_esp.exe"
if [ -f "$INFOSTAT_DL" ]; then
    cd "$HOME/Descargas"
    wine infostatinstaller_esp.exe
elif [ -f "$INFOSTAT_CUR" ]; then
    wine "$INFOSTAT_CUR"
else
    echo "No se encontró el instalador de InfoStat (InfoStatSetup.exe) ni en Descargas ni en el directorio actual."
fi

echo "Instalación completada."
# Crear accesos directos en el escritorio
DESKTOP_DIR="$HOME/Desktop"

# Acceso directo para InfoStat
INFOSTAT_DESKTOP="$DESKTOP_DIR/InfoStat.desktop"
cat > "$INFOSTAT_DESKTOP" <<EOL
[Desktop Entry]
Name=InfoStat
Comment=Iniciar InfoStat con Wine
Exec=wine \"$HOME/.wine/drive_c/Program Files/InfoStat/InfoStat.exe\"
Icon=wine
Terminal=false
Type=Application
Categories=Education;
EOL
chmod +x "$INFOSTAT_DESKTOP"

# Acceso directo para LibreOffice
LIBREOFFICE_DESKTOP="$DESKTOP_DIR/LibreOffice.desktop"
cat > "$LIBREOFFICE_DESKTOP" <<EOL
[Desktop Entry]
Name=LibreOffice
Comment=Suite ofimática LibreOffice
Exec=libreoffice
Icon=libreoffice-main
Terminal=false
Type=Application
Categories=Office;
EOL
chmod +x "$LIBREOFFICE_DESKTOP"

echo "Instalación completada. Accesos directos creados en el escritorio."
