# DB-Monitor-Alerts: Sistema Automatizado de Monitoreo y Respaldo de Bases de Datos

Este proyecto implementa una solución automatizada para la administración, mantenimiento y monitoreo en tiempo real de servidores de bases de datos relacionales. Su objetivo principal es garantizar la continuidad del negocio mediante alertas proactivas ante incidentes críticos de infraestructura y la automatización de políticas de respaldo (Backups).

## 🚀 Problema que Resuelve
En entornos corporativos de alta disponibilidad, las caídas de servicios por falta de espacio en disco o fallos en las instancias de bases de datos generan pérdidas críticas. Este sistema elimina la necesidad de revisiones manuales diarias, automatizando el monitoreo de recursos y la notificación inmediata al equipo de Soporte TI antes de que el usuario final se vea afectado.

## 🛠️ Tecnologías Utilizadas
* **Motor de Base de Datos:** SQL Server / PostgreSQL
* **Scripting y Automatización:** PowerShell (Windows) / Bash (Linux)
* **Contenedores:** Docker (para el despliegue rápido del entorno)
* **Notificaciones:** Telegram API (Bot integrado para alertas móviles)

## 📊 Arquitectura del Sistema
1. **Verificación de Salud:** El script inspecciona el estado del servicio de base de datos y la capacidad disponible en los volúmenes de almacenamiento.
2. **Mantenimiento Automatizado:** Si las métricas son correctas, ejecuta los planes de mantenimiento y genera un Backup comprimido con marca de tiempo.
3. **Mapeo de Errores y Alertas:** Si el espacio en disco es menor al 15% o el servicio está detenido, se dispara un JSON vía Webhook que envía una alerta detallada directamente al canal de soporte en Telegram.

## 📁 Estructura del Repositorio
* `/scripts`: Contiene los scripts de automatización de mantenimiento y monitoreo.
* `/config`: Archivos de configuración de variables de entorno y credenciales seguras.
* `docker-compose.yml`: Archivo para levantar la base de datos de prueba en segundos.

## 👥 Autor
* **Guadalupe Ibarra Lopez** - *Administrador de Bases de Datos / Especialista en Soporte TI*
* LinkedIn: www.linkedin.com/in/guadalupe-ibarra-lopez

