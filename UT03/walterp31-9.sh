#!/bin/bash
# Directorio origen y destino espejo
ORIGEN="/home/walter"
DESTINO="/bacwalter/espejo"

# Aseguramos que el directorio espejo existe
mkdir -p "$DESTINO"

# Ejecutamos la sincronización conservando permisos y fechas
rsync -a --delete "$ORIGEN/" "$DESTINO/"

exit 0


