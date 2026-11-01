#!/bin/bash
# ==============================================================================
# Script: walterp31-5.sh
# Descripción: Mantenimiento de registros de /var/log buscando errores o fallos.
# ==============================================================================

# Definir la ruta del informe de salida
INFORME="/tmp/informe_errores_sistema.txt"

echo "==================================================" > "$INFORME"
echo "   INFORME DE ERRORES DEL SISTEMA - $(date)       " >> "$INFORME"
echo "==================================================" >> "$INFORME"
echo "" >> "$INFORME"

echo "Iniciando análisis de registros en /var/log..."

# 1. Recorrer los archivos de registro ubicados en /var/log
for archivo in /var/log/*.log; do
    # Comprobar si el archivo realmente existe y es legible
    if [ -f "$archivo" ]; then

        # 2. Filtrar líneas que contengan "error" o "fail" (sin distinguir mayúsculas/minúsculas con -i)
        # Usamos grep para buscar coincidencias de forma eficiente
        coincidencias=$(grep -i -E "error|fail" "$archivo" 2>/dev/null)

        # Si se encontraron líneas con errores en este archivo
        if [ -n "$coincidencias" ]; then
            echo "-> Procesando archivo: $archivo (Encontrados errores)"

            # 3. Añadir separación visual y cabecera clara en el informe para el administrador
            echo "--------------------------------------------------" >> "$INFORME"
            echo " FICHERO DE ORIGEN: $archivo" >> "$INFORME"
            echo "--------------------------------------------------" >> "$INFORME"

            # Añadir las líneas encontradas al informe
            echo "$coincidencias" >> "$INFORME"
            echo "" >> "$INFORME"
        fi
    fi
done

echo "=================================================="
echo "¡Análisis finalizado con éxito!"
echo "El informe detallado se ha generado en: $INFORME"
echo "=================================================="

exit 0
