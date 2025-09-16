#! /bin/bash

USUARIO="laboratorio"
HOME_USUARIO="/home/$USUARIO"

if [ ! -d "$HOME_USUARIO" ]; then
	echo "El usuario '$USUARIO' no existe en el ssitema"
	exit 1
else
	echo "Se encontro el usuario"
fi

DESCARGAS_DIR="$HOME_USUARIO/Descargas"
ESCRITORIO_DIR="$HOME_USUARIO/Escritorio"
echo "USUARIO: $USUARIO"
echo "Descargas: $DESCARGAS_DIR"

########################################################
# Instalacion de WINE
########################################################
echo "Instalando Wine..."
dpkg --add-architecture i386
apt update
apt install -y wget gnupg2 software-properties-common

mkdir -pm755 /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources

apt update
apt install --install-recommends -y winehq-stable

echo "✅ Wine instalado. Versión:"
sudo -u "$USUARIO" wine --version


########################################################
# Instalacion de Libreoffice
########################################################
apt install -y libreoffice

########################################################
# Instalacion de Evince
########################################################
apt install -y evince

########################################################
# Instalacion de p7zip y unzip
########################################################
apt install -y p7zip-full unzip

########################################################
# Instalacion de Libreoffice
########################################################
apt install -y libreoffice

########################################################
# Instalacion de infostat
########################################################
INFOSTAT_INSTALLER="$DESCARGAS_DIR/infostatinstaller_esp.exe"
if [ -f "$INFOSTAT_INSTALLER" ]; then
	echo "Instalador encontrado en descargas"
	sudo -u "$USUARIO" env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY wine "$INFOSTAT_INSTALLER"
else
	echo "No se encontro el instalador en descargas"
fi


########################################################
# Crear accesos directos
########################################################
mkdir -p "$DESKTOP_DIR"

#Acceso directo de infostat
INFOSTAT_DESKTOP="$DESKTOP_DIR"/InfoStat.desktop
cat > "$INFOSTAT_DESKTOP" <<EOL
[Desktop Entry]
Name=InfoStat
Comment=Iniciar InfoStat con Wine
Exec=wine "$HOME_USUARIO/.wine/drive_c/Program Files/InfoStat/InfoStat.exe"
Icon=wine
Terminal=false
Type=Application
Categories=Education;
EOL
chmod +x "$INFOSTAT_DESKTOP"
chown "$USUARIO:$USUARIO" "$INFOSTAT_DESKTOP"
