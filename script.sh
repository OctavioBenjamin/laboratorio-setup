#!/bash/bash
#Script de instalacion de infostat y libreoffice

function paso(){
	echo -e "\n[+] $1\n"
	sleep 1
}

# -- 3. Instalacion de paquetes basicos
paso "Paquetes basicos"
sudo apt update
sudo apt install -y wget unzip libreoffice

# -- 4. Instalacion de wine 
paso "Wine"
sudo dpkg --add-architecture i386
sudo mkdir -pm /etc/apt/keyrings
wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
sudo wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/noble/winehq-noble.sources
sudo apt update
sudo apt install --install-recommends -y winehq-stable

# -- 5 Instalar infostat
paso "Instalando infostat"
USUARIO_LAB=$(getent passwd | cut -d: -f1 | grep '^lab' | head -n 1)
if [ -z "$USUARIO_LAB" ]; then
	echo "No se encontro usuario Laboratorio"
else
	echo "Se encontro $USUARIO_LAB"
	if [ -f "/home/$USUARIO_LAB/Descargas/infostatinstaller_esp.exe" ]; then
		sudo -u "$USUARIO_LAB" wine "/home/$USUARIO_LAB/Descargas/InfostatSetup.exe"
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

# -- 7 Desactivar suspension automatica
paso "Desactivando la suspension automatica"
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

echo "Termino el script. REINICIAR POR LAS DUDAS"
