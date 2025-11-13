#!/bin/bash
# ------------------------------------------------------------
# Script: disks.sh
# Descripción: Muestra los filesystems/discos conectados al sistema,
#              incluyendo su tamaño total y espacio libre (en bytes).
#              Al final, permite volver al menú principal.
#
# Ejecutar antes: sed -i 's/\r$//' *.sh
# Esto elimina todos los \r finales y convierte los archivos a formato UNIX.
# ------------------------------------------------------------

echo ""                                 # Línea en blanco para separación visual
echo "=== CONNECTED FILESYSTEMS AND DISKS ==="
echo ""

# Ejecuta el comando 'df' con las siguientes opciones:
# -B1   → Muestra tamaños en bytes (1 byte = unidad base)
# --output=source,size,avail → Limita las columnas a:
#     source = nombre del dispositivo
#     size   = tamaño total
#     avail  = espacio libre disponible
df -B1 --output=source,size,avail | awk '
    NR==1 {next}  # Salta la primera línea (cabecera de df)

    # Filtra los sistemas de archivos que no sean físicos (evita tmpfs, loop, etc.)
    $1 !~ /tmpfs|loop/ {
        total=$2   # Tamaño total del disco en bytes
        free=$3    # Espacio libre en bytes

        # Imprime cada línea formateada:
        # %-25s  → nombre del disco, alineado a la izquierda en 25 caracteres
        # %-15s  → valores numéricos alineados
        printf "%-25s  Total: %-15s  Free: %-15s\n", $1, total, free
    }
'
