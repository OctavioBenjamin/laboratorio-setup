#!/bash/bash
#Script de instalacion de infostat y libreoffice

# --  Instalacion de wine 
echo "Wine"
sudo dpkg --add-architecture i386
sudo mkdir -pm /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources
sudo apt update
sudo apt install --install-recommends -y winehq-stable

# -- 5 Instalar infostat
echo "Instalando infostat"
USUARIO_LAB=$(getent passwd | cut -d: -f1 | grep '^lab' | head -n 1)
if [ -z "$USUARIO_LAB" ]; then
	echo "No se encontro usuario Laboratorio"
else
	echo "Se encontro $USUARIO_LAB"
	if [ -f "/home/$USUARIO_LAB/Descargas/infostatinstaller_esp.exe" ]; then
		sudo -u "$USUARIO_LAB" wine "/home/$USUARIO_LAB/Descargas/infostatinstaller_esp.exe"
	else
		echo "No se encontro el instalador de infostat en descargas"
	if
if

# -- 6 Crear acceso directo de infostat
paso "Creando acceso directo de infostat"
sudo tee /usr/share/applications/infostat.desktop > /dev/null <<EOL
[Desktop Entry]
Name=Infostat
Exec=wine "/home/$USUARIO_LAB/.wine/drive_c/Program Files (x86)/Infostat/Infostat.exe"
Type=Application
Icon=wine
Categories=Education;
EOL

echo "Termino el script. REINICIAR POR LAS DUDAS"
