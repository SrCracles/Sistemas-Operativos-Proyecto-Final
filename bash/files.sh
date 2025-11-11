#!/bin/bash
# ------------------------------------------------------------
# Script: files.sh
# Descripción: Muestra los 10 archivos más grandes de un disco
#              o filesystem especificado por el usuario.
# ------------------------------------------------------------

echo ""
echo "=== TOP 10 LARGEST FILES ==="
echo ""

# Mostrar ejemplos de filesystems reales (máx 5)
echo "Available filesystems (examples):"

# Intentar mostrar los primeros 5 filesystems reales
df -h --output=source,target 2>/dev/null | \
awk 'NR>1 && $1 !~ /tmpfs|loop/ {printf "• %-15s mounted on %s\n", $1, $2}' | head -5

# Añadir ejemplos útiles comunes
echo "• /home           (user home directory)"
echo "• /usr            (system programs and libraries)"
echo "• /var            (logs and variable data)"
echo "• /tmp            (temporary files)"
echo "• /cygdrive/c     (main Windows drive under Cygwin)"
echo ""

# Solicitar al usuario la ruta del filesystem o carpeta
read -p "Enter the filesystem or directory path to analyze: " path

# Validar que la ruta exista y sea accesible
if [[ ! -d "$path" ]]; then
    echo ""
    echo "Error: The specified path does not exist or is not a directory."
    echo ""
    read -p "Press ENTER to return to the menu..."
    bash menu.sh
    exit 1
fi

echo ""
echo "Analyzing, please wait..."
echo "(This may take a few seconds depending on directory size...)"
echo ""

# Buscar y listar los 10 archivos más grandes (en bytes)
# Limita la profundidad a 5 niveles para evitar demoras excesivas
find "$path" -type f -maxdepth 5 -exec du -b {} + 2>/dev/null | \
sort -nr | head -10 | \
awk '{
    size=$1
    name=$2
    printf "%-12s %s\n", size, name
}'

echo ""
read -p "Press ENTER to return to the menu..."
bash menu.sh
