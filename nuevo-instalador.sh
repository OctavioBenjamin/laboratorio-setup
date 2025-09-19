#! /bin/bash

########################################################
# Quitar suspension de pantalla
########################################################
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'


USUARIO="laboratorio"
HOME_USUARIO="/home/$USUARIO"

ADMINNAME="admin"

# 1) crear usuario con home y bash
useradd -m -s /bin/bash "$ADMINNAME"

# 2) añadir al grupo sudo
usermod -aG sudo "$ADMINNAME"


if [ ! -d "$HOME_USUARIO" ]; then
	echo
	echo "El usuario '$USUARIO' no existe en el ssitema"
 	echo
	exit 1
else
	echo
	echo "Se encontro el usuario"
 	echo
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
echo
echo "✅ Wine instalado. Versión:"
echo
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
# Instalacion de infostat
########################################################
INFOSTAT_INSTALLER="$DESCARGAS_DIR/infostatinstaller_esp.exe"
if [ -f "$INFOSTAT_INSTALLER" ]; then
	echo
	echo "Instalador encontrado en descargas"
 	echo
	sudo -u "$USUARIO" env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY wine "$INFOSTAT_INSTALLER"
else
	echo "No se encontro el instalador en descargas"
fi


########################################################
# Crear accesos directos

########################################################

DESKTOP_DIR="$HOME/Escritorio"

# Acceso directo para InfoStat
#INFOSTAT_DESKTOP="$ESCRITORIO_DIR/InfoStat.desktop"
#cat > "$INFOSTAT_DESKTOP" <<EOL
#[Desktop Entry]
#Name=InfoStat
#Comment=Iniciar InfoStat con Wine
#Exec=wine \"$HOME/.wine/drive_c/Program Files/InfoStat/InfoStat.exe\"
#Icon=wine
#Terminal=false
#Type=Application
#Categories=Education;
#EOL
#chmod +x "$INFOSTAT_DESKTOP"

# Acceso directo para LibreOffice
LIBREOFFICE_DESKTOP="$ESCRITORIO_DIR/LibreOffice.desktop"
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
