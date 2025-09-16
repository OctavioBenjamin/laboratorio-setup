#!/bash/bash
#Script de instalacion de infostat y libreoffice
# -- Instalacion de paquetes basicos
echo "Paquetes basicos"
sudo apt update

# -- Desactivar suspension automatica
echo "Desactivando la suspension automatica"
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

echo "Termino el script. REINICIAR POR LAS DUDAS"
