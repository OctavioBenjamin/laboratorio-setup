# Setup basico para laboratorio

# NUEVOS PASOS

1. Entrar a admin
2. Darle permisos sudo a laboratorio
3. Iniciar laboratorio
4. Descargar infostat en descargas
5. Clonar el repo
6. Ejectuar el nuevo script
7. Volver a admin y sacarle permisos sudo a laboratorio

### Recordar
1. Descargar infostat
2. Dejarlo en la carpeta Descargas
3. Nombrarlo como infostatinstaller_esp.exe
### Instalar git
```sh
sudo apt install git
```
# Como usar

Primero! Clonar el repositorio y moverse
```sh
git clone https://github.com/OctavioBenjamin/laboratorio-setup
cd laboratorio-setup
```

### Script sh
Desactiva la suspension de la pantalla.
```sh
sudo sh script.sh
```
### script-install-wine-infostat, libreofice, interprete de pdf y descompresor de archivos
Falta corregirlo, deberia instalar wine y luego configurar infostat, despues genera un acceso directo en el escritorio.
```sh
sudo bash instalar-paquetes.sh
```
