#!/bin/bash
DESTINO="/bacwalter"
FECHA=$(date +%B-%Y)
TAR_FILE="$DESTINO/CopTot-$FECHA.tar.bz2"

tar -cjf "$TAR_FILE" /home 2>/dev/null
exit 0


