#!/bin/bash
# Script de desinstalación automatizada desde programas.txt

FICHERO="programas.txt"

# Comprobar si el archivo de texto existe antes de continuar
if [ ! -f "$FICHERO" ]; then
    echo "Error: No se encuentra el fichero $FICHERO en el directorio actual."
    exit 1
fi

echo "== Iniciando desinstalación automatizada =="

# Bucle while para leer el fichero línea a línea
while IFS= read -r programa; do
    # Ignorar líneas vacías
    [ -z "$programa" ] && continue

    echo "Comprobando programa: $programa"

    # Comprobamos si el paquete está instalado usando dpkg
    if dpkg -l | grep -q "$programa"; then
        echo "-> El programa '$programa' está instalado. Desinstalando..."
        apt-get purge -y --auto-remove "$programa" &> /dev/null
    else
        echo "-> El programa '$programa' NO está instalado en el sistema. Saltando..."
    fi

    echo "--------------------------------------------------"
done < "$FICHERO"

echo "== Proceso de desinstalación finalizado =="
exit 0
