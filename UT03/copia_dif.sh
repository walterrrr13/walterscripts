#!/bin/bash
DESTINO="/bacwalter"
SEMANA=$(date +%V)
TAR_FILE="$DESTINO/CopDifSem-$SEMANA.tar.bz2"

# Crear copia comprimida de /home
tar -cjf "$TAR_FILE" /home 2>/dev/null
exit 0


