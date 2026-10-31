#!/bin/bash

# ==============================================================================
# SCRIPT DE MONITOREO Y RESPALDO AUTOMÁTICO PARA POSTGRESQL (LINUX/WSL)
# Desarrollado por: Guadalupe Ibarra Lopez
# ==============================================================================

# --- CONFIGURACIÓN DE VARIABLES ---
DB_NAME="corporativo_db"         # Tu nueva base de datos creada
BACKUP_DIR="$HOME/db_backups"    # Carpeta donde se guardarán los respaldos
FECHA=$(date +%Y%m%d_%H%M%S)     # Marca de tiempo para el archivo
LIMITE_DISCO=85                  # Porcentaje máximo de alerta para el disco

# Crear directorio de respaldos si no existe
mkdir -p "$BACKUP_DIR"

echo "====================================================================="
echo "Iniciando verificación del sistema: $(date)"
echo "====================================================================="

# 1. VERIFICACIÓN DEL SERVICIO POSTGRESQL
if pg_isready -q; then
    echo "[OK] El servicio de PostgreSQL está activo y respondiendo."
else
    echo "[CRÍTICO] El servicio de PostgreSQL está DETENIDO o no responde."
    exit 1
fi

# 2. MONITOREO DE ESPACIO EN DISCO
USO_DISCO=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$USO_DISCO" -gt "$LIMITE_DISCO" ]; then
    echo "[ALERTA] Almacenamiento crítico. Uso de disco actual: ${USO_DISCO}% (Límite: ${LIMITE_DISCO}%)"
else
    echo "[OK] Almacenamiento seguro. Uso de disco actual: ${USO_DISCO}%"
fi

# 3. AUTOMATIZACIÓN DEL RESPALDO (BACKUP)
echo "Generando respaldo de la base de datos: $DB_NAME..."
RESPALDO_FILE="$BACKUP_DIR/${DB_NAME}_backup_${FECHA}.sql"

# Ejecuta pg_dump usando el usuario maestro administrador
if sudo -u postgres pg_dump "$DB_NAME" > "$RESPALDO_FILE" 2>/dev/null; then
    echo "[ÉXITO] Respaldo creado correctamente en: $RESPALDO_FILE"
else
    echo "[ERROR] Falló la creación del respaldo de la base de datos."
fi

echo "====================================================================="
echo "Monitoreo finalizado con éxito."
echo "====================================================================="
