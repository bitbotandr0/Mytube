#!/bin/bash
# Instalar lolcat

gem install lolcat

# Función para verificar si un paquete está instalado
check_install() {
    dpkg -s "$1" &> /dev/null || {
        echo "Instalando $1..."
        apt install "$1" -y
    }
}

# Función para imprimir mensajes con colores usando lolcat
colors() {
    echo -e "$1" | lolcat
}

# Verificar e instalar dependencias necesarias
check_install ruby
check_install figlet
check_install lolcat

# Limpia la pantalla
clear

# Crear la carpeta play_list si no existe
mkdir -p /data/data/com.termux/files/home/mytube/play_list

# Mensajes de bienvenida
colors "$(figlet -f big 'My_TUBe')"
colors "$(figlet 'Download')"

colors "Bienvenid@ a youtube download version 1.1 funcional solo para termux"

sleep 0.5

# Instrucciones iniciales
colors "A continuación actualizaremos el sistema"
sleep 0.5
colors "Descargaremos repositorios y programas necesarios"
sleep 0.5
colors "Si usted ya tiene instalado todos los programas"
sleep 0.5
colors "Digite (N) para omitir este paso"
sleep 0.5
colors "Caso contrario digite (Y)"

# Leer la opción del usuario
read -p "Digite su opción: " opc
clear

# Procesar la opción del usuario
if [[ $opc == n ]] || [[ $opc == N ]]; then
    # Opciones para descargar videos o música
    colors "Seleccione 1) si desea descargar un video"
    sleep 1
    colors "Seleccione 2) si desea descargar en formato mp3"
    sleep 1
    colors "Seleccione 3) si desea salir"

    opcion=0
    while [[ $opcion -ne 3 ]]; do
        read -p "Ingrese una opción: " opcion
        case $opcion in
            1)
                colors "Ingresa una URL"
                read URL
                colors "Descargando Video"
                yt-dlp -o "/data/data/com.termux/files/home/mytube/play_list/%(title)s.%(ext)s" $URL
                ;;
            2)
                colors "Ingresa URL"
                read URL
                colors "Descargando"
                yt-dlp -x --audio-format mp3 -o "/data/data/com.termux/files/home/mytube/play_list/%(title)s.%(ext)s" $URL
                ;;
            3) exit ;;
            *)
                colors "¡Ups! Opción no válida, intente de nuevo"
                sleep 1
                ;;
        esac
    done
elif [[ $opc == y ]] || [[ $opc == Y ]]; then
# instalando dependencias necesarias
    apt update && apt upgrade -y
    check_install  ffmpeg
    check_install python
    pip3 install yt-dlp || apt install python3-pip
    colors "Actualizando el sistema..."
    colors "Instalando dependencias adicionales..."
    # Agrega aquí cualquier otro paquete que necesites instalar
    colors "Proceso de actualización y descarga completado."

clear

    colors "Bienvenidos"
    colors "Seleccione 1) para descargar un video"
    colors "Seleccione 2) para descargar en formato mp3"
    colors "Seleccione 3) para Salir"

    opi=0
    until [ $opi -eq 3 ]; do
        read -p "elija la opción  : " opi
        case $opi in
            1)
                colors "Ingresa una Url"
                read URL
                colors "descargando video"
                yt-dlp -o "/data/data/com.termux/files/home/mytube/play_list/%(title)s.%(ext)s" $URL
                ;;
            2)
                colors "Ingrese la Url"
                read URL
                colors "descargando cancion"
                sleep 1
                yt-dlp -x --audio-format mp3 -o "/data/data/com.termux/files/home/mytube/play_list/%(title)s.%(ext)s" $URL
                ;;
            3) exit ;;
            *)
                colors "opción no válida , intente de nuevo"
                sleep 1
                ;;
        esac
    done
else
    colors "digitó mal, inténtalo de nuevo"
    sleep 1
fi
