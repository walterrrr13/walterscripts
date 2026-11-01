#!/bin/bash
# ==============================================================================
# Script: waltersp31-7.sh
# Descripción: Comprueba el espacio en disco de las particiones. Si alguna
#              supera el umbral del 80%, añade una línea a un fichero de registro.
# ==============================================================================

# Fichero de registro propio donde se dejará constancia de las alertas
LOG_REGISTRO="/var/log/espacio_disco.log"

# Umbral de ocupación establecido (80%)
UMBRAL=80

# Recorrer las particiones del sistema omitiendo la cabecera de df
# Usamos awk para extraer el porcentaje de uso (quitando el símbolo %) y la partición
df -h | tail -n +2 | while read -r linea; do
    # Extraer el punto de montaje (última columna) y el porcentaje de uso (penúltima columna)
    particion=$(echo "$linea" | awk '{print $NF}')
    uso_pct=$(echo "$linea" | awk '{print $(NF-1)}' | tr -d '%')

    # Validar que el valor extraído sea un número entero para evitar errores
    if [[ "$uso_pct" =~ ^[0-9]+$ ]]; then
        # Comprobar si supera el umbral del 80%
        if [ "$uso_pct" -ge "$UMBRAL" ]; then
            # Obtener fecha y hora actuales
            fecha_actual=$(date '+%F %T')

            # Registrar la incidencia en el fichero propio
            echo "[$fecha_actual] ALERTA: La partición '$particion' está al ${uso_pct}% de uso." >> "$LOG_REGISTRO"
        fi
    fi
done

exit 0
