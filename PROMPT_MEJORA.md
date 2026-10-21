# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Como saber que terminaste

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Cloud Ops, Especialidad Analista, Senior

### Brecha de conocimiento
Implementa soluciones de servidores de aplicación como Apache Tomcat o IBM Websphere de manera integral y realiza optimizaciones sobre las mismas. Candidato con experiencia en soluciones empresariales de infraestructura.

### Reto
- Tema: Manejo de Middleware
- Seniority: senior-l2
- Tipo: practical
- Título: Optimización de Servidores de Aplicación
- Tiempo estimado: 4 semanas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Implementación Inicial — objetivo: Implementar un servidor de aplicación básico que pueda manejar solicitudes HTTP y persistir datos en una base de datos relacional. — entregable (NO resolver): Servidor de aplicación operativo con persistencia de datos.
- Fase 2: Optimización de Rendimiento — objetivo: Optimizar el servidor de aplicación para manejar un tráfico de 5 000 solicitudes por segundo con una latencia máxima de 200 ms. — entregable (NO resolver): Servidor de aplicación optimizado para manejar 5 000 solicitudes por segundo con una latencia máxima de 200 ms.
- Fase 3: Alta Disponibilidad y Recuperación — objetivo: Implementar medidas de alta disponibilidad y recuperación para garantizar un tiempo de actividad del 99.9%. — entregable (NO resolver): Servidor de aplicación con alta disponibilidad y recuperación automática, documentado con decisiones y trade-offs.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: variables.tf ===
# Variables globales para personalizar la infraestructura por ambiente.
# Estas variables son usadas por los módulos y definen parámetros como tamaños de instancia,
# número de réplicas, configuraciones de red y seguridad.

variable "aws_region" {
  description = "Región de AWS donde se desplegará la infraestructura."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Ambiente de despliegue (dev, qa, prod)."
  type        = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "El ambiente debe ser uno de: dev, qa, prod."
  }
}

variable "vpc_cidr" {
  description = "Bloque CIDR para la VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "Lista de CIDRs para subredes públicas."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnets" {
  description = "Lista de CIDRs para subredes privadas."
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "database_subnets" {
  description = "Lista de CIDRs para subredes de base de datos."
  type        = list(string)
  default     = ["10.0.201.0/24", "10.0.202.0/24", "10.0.203.0/24"]
}

variable "tomcat_cluster_name" {
  description = "Nombre del cluster de Tomcat."
  type        = string
  default     = "tomcat-cluster"
}

variable "rds_instance_class" {
  description = "Clase de instancia para RDS PostgreSQL."
  type        = string
  default     = "db.t3.medium"
}

variable "rds_allocated_storage" {
  description = "Almacenamiento asignado para RDS PostgreSQL (GB)."
  type        = number
  default     = 20
}

variable "rds_max_allocated_storage" {
  description = "Almacenamiento máximo asignado para RDS PostgreSQL (GB)."
  type        = number
  default     = 100
}

variable "rds_engine_version" {
  description = "Versión del motor de PostgreSQL."
  type        = string
  default     = "13.4"
}

variable "rds_multi_az" {
  description = "Habilitar despliegue multi-AZ para RDS."
  type        = bool
  default     = true
}

variable "rds_backup_retention_period" {
  description = "Período de retención de backups para RDS (días)."
  type        = number
  default     = 7
}

variable "rds_skip_final_snapshot" {
  description = "Omitir la creación de un snapshot final al eliminar la instancia RDS."
  type        = bool
  default     = false
}

variable "rds_storage_encrypted" {
  description = "Habilitar cifrado para el almacenamiento de RDS."
  type        = bool
  default     = true
}

variable "alb_internal" {
  description = "Indica si el Application Load Balancer es interno."
  type        = bool
  default     = false
}

variable "alb_idle_timeout" {
  description = "Tiempo de espera inactivo para el ALB (segundos)."
  type        = number
  default     = 60
}

variable "alb_http_tcp_listeners" {
  description = "Lista de listeners HTTP/TCP para el ALB."
  type = list(object({
    port               = number
    protocol           = string
    target_group_index = number
  }))
  default = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}

variable "alb_https_listeners" {
  description = "Lista de listeners HTTPS para el ALB."
  type = list(object({
    port               = number
    protocol           = string
    certificate_arn    = string
    target_group_index = number
  }))
  default = []
}

variable "alb_target_groups" {
  description = "Lista de target groups para el ALB."
  type = list(object({
    name             = string
    backend_protocol = string
    backend_port     = number
    target_type      = string
    health_check = object({
      path                = string
      port                = string
      healthy_threshold   = number
      unhealthy_threshold = number
      timeout             = number
      interval            = number
      matcher             = string
    })
  }))
  default = [
    {
      name             = "tomcat-tg"
      backend_protocol = "HTTP"
      backend_port     = 8080
      target_type      = "ip"
      health_check = {
        path                = "/health"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 5
        interval            = 30
        matcher             = "200"
      }
    }
  ]
}

variable "monitoring_latency_threshold" {
  description = "Umbral de latencia para alarmas de CloudWatch (milisegundos)."
  type        = number
  default     = 200
}

variable "monitoring_error_threshold" {
  description = "Umbral de errores para alarmas de CloudWatch (porcentaje)."
  type        = number
  default     = 1
}

variable "monitoring_cpu_threshold" {
  description = "Umbral de utilización de CPU para escalado automático (porcentaje)."
  type        = number
  default     = 70
}

variable "monitoring_memory_threshold" {
  description = "Umbral de utilización de memoria para escalado automático (porcentaje)."
  type        = number
  default     = 80
}

// === ARCHIVO: providers.tf ===
# Configuración de providers y versiones requeridas para Terraform.
# Este archivo define el proveedor AWS y las versiones de Terraform y providers,
# asegurando compatibilidad y replicabilidad en todos los ambientes.

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuración del provider AWS.
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Terraform   = "true"
      Project     = "banking-platform"
    }
  }
}

# Configuración del backend remoto para Terraform.
# Nota: Este bloque se completa en `backend.tf` con los detalles específicos del bucket S3 y la tabla DynamoDB.
# Se incluye aquí como referencia para recordar que el backend debe configurarse.

// === ARCHIVO: modules/tomcat-cluster/variables.tf ===
# Variables para el módulo de cluster de Tomcat.
# Estas variables permiten personalizar el tamaño de las instancias, el número de réplicas,
# la imagen Docker utilizada y las políticas IAM aplicadas al servicio.

variable "cluster_name" {
  description = "Nombre del cluster ECS para Tomcat."
  type        = string
}

variable "desired_count" {
  description = "Número deseado de tareas en el servicio ECS."
  type        = number
  default     = 2
}

variable "cpu" {
  description = "CPU asignada a cada tarea de ECS (unidades de CPU)."
  type        = number
  default     = 1024
}

variable "memory" {
  description = "Memoria asignada a cada tarea de ECS (MB)."
  type        = number
  default     = 2048
}

variable "docker_image" {
  description = "Imagen Docker para el contenedor de Tomcat."
  type        = string
  default     = "tomcat:9.0-jdk11-openjdk-slim"
}

variable "container_port" {
  description = "Puerto expuesto por el contenedor de Tomcat."
  type        = number
  default     = 8080
}

variable "subnets" {
  description = "Lista de IDs de subredes donde se desplegará el servicio ECS."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de IDs de security groups para el servicio ECS."
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN del target group para el ALB."
  type        = string
}

variable "enable_execute_command" {
  description = "Habilitar execute command para el servicio ECS."
  type        = bool
  default     = true
}

variable "deployment_minimum_healthy_percent" {
  description = "Porcentaje mínimo de tareas saludables durante el despliegue."
  type        = number
  default     = 50
}

variable "deployment_maximum_percent" {
  description = "Porcentaje máximo de tareas durante el despliegue."
  type        = number
  default     = 200
}

variable "autoscaling_min_capacity" {
  description = "Capacidad mínima para el escalado automático."
  type        = number
  default     = 2
}

variable "autoscaling_max_capacity" {
  description = "Capacidad máxima para el escalado automático."
  type        = number
  default     = 10
}

variable "autoscaling_cpu_target" {
  description = "Umbral de utilización de CPU para escalado automático (porcentaje)."
  type        = number
  default     = 70
}

variable "autoscaling_memory_target" {
  description = "Umbral de utilización de memoria para escalado automático (porcentaje)."
  type        = number
  default     = 80
}

variable "iam_role_arn" {
  description = "ARN del rol IAM para el servicio ECS."
  type        = string
}

// === ARCHIVO: modules/rds-postgresql/variables.tf ===
# Variables para el módulo de RDS PostgreSQL.
# Estas variables permiten personalizar la instancia de RDS, incluyendo tamaño,
# credenciales, configuración de replicación y backup.

variable "identifier" {
  description = "Identificador para la instancia RDS."
  type        = string
}

variable "engine" {
  description = "Motor de base de datos."
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Versión del motor de base de datos."
  type        = string
}

variable "instance_class" {
  description = "Clase de instancia para RDS."
  type        = string
}

variable "allocated_storage" {
  description = "Almacenamiento asignado para RDS (GB)."
  type        = number
}

variable "max_allocated_storage" {
  description = "Almacenamiento máximo asignado para RDS (GB)."
  type        = number
}

variable "storage_encrypted" {
  description = "Habilitar cifrado para el almacenamiento de RDS."
  type        = bool
}

variable "database_name" {
  description = "Nombre de la base de datos."
  type        = string
  default     = "bankingdb"
}

variable "username" {
  description = "Nombre de usuario para la base de datos."
  type        = string
  default     = "admin"
}

variable "password" {
  description = "Contraseña para la base de datos."
  type        = string
  sensitive   = true
}

variable "port" {
  description = "Puerto para la base de datos."
  type        = number
  default     = 5432
}

variable "multi_az" {
  description = "Habilitar despliegue multi-AZ para RDS."
  type        = bool
}

variable "publicly_accessible" {
  description = "Indica si la instancia RDS es accesible públicamente."
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "Lista de IDs de subredes para RDS."
  type        = list(string)
}

variable "vpc_security_group_ids" {
  description = "Lista de IDs de security groups para RDS."
  type        = list(string)
}

variable "backup_retention_period" {
  description = "Período de retención de backups para RDS (días)."
  type        = number
}

variable "skip_final_snapshot" {
  description = "Omitir la creación de un snapshot final al eliminar la instancia RDS."
  type        = bool
}

variable "deletion_protection" {
  description = "Habilitar protección contra eliminación para RDS."
  type        = bool
  default     = true
}

variable "performance_insights_enabled" {
  description = "Habilitar Performance Insights para RDS."
  type        = bool
  default     = true
}

variable "performance_insights_retention_period" {
  description = "Período de retención para Performance Insights (días)."
  type        = number
  default     = 7
}

variable "monitoring_interval" {
  description = "Intervalo de monitoreo para RDS (segundos)."
  type        = number
  default     = 60
}

// === ARCHIVO: modules/load-balancer/variables.tf ===
# Variables para el módulo de Application Load Balancer (ALB).
# Estas variables permiten personalizar las subredes, certificados SSL y targets del balanceador.

variable "name" {
  description = "Nombre del Application Load Balancer."
  type        = string
}

variable "internal" {
  description = "Indica si el ALB es interno."
  type        = bool
}

variable "load_balancer_type" {
  description = "Tipo de load balancer."
  type        = string
  default     = "application"
}

variable "subnets" {
  description = "Lista de IDs de subredes para el ALB."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Lista de IDs de security groups para el ALB.
  type        = list(string)
}

variable "idle_timeout" {
  description = "Tiempo de espera inactivo para el ALB (segundos)."
  type        = number
}

variable "enable_deletion_protection" {
  description = "Habilitar protección contra eliminación para el ALB."
  type        = bool
  default     = true
}

variable "http_tcp_listeners" {
  description = "Lista de listeners HTTP/TCP para el ALB."
  type = list(object({
    port               = number
    protocol           = string
    target_group_index = number
  }))
}

variable "https_listeners" {
  description = "Lista de listeners HTTPS para el ALB."
  type = list(object({
    port               = number
    protocol           = string
    certificate_arn    = string
    target_group_index = number
  }))
}

variable "target_groups" {
  description = "Lista de target groups para el ALB."
  type = list(object({
    name             = string
    backend_protocol = string
    backend_port     = number
    target_type      = string
    health_check = object({
      path                = string
      port                = string
      healthy_threshold   = number
      unhealthy_threshold = number
      timeout             = number
      interval            = number
      matcher             = string
    })
  }))
}

variable "tags" {
  description = "Tags para el ALB."
  type        = map(string)
  default     = {}
}

// === ARCHIVO: modules/monitoring/variables.tf ===
# Variables para el módulo de monitoreo.
# Estas variables permiten configurar umbrales para alarmas de CloudWatch,
# incluyendo latencia, errores y saturación de recursos.

variable "cluster_name" {
  description = "Nombre del cluster ECS monitoreado."
  type        = string
}

variable "service_name" {
  description = "Nombre del servicio ECS monitoreado."
  type        = string
}

variable "alb_arn_suffix" {
  description = "ARN suffix del Application Load Balancer."
  type        = string
}

variable "latency_threshold" {
  description = "Umbral de latencia para alarmas (milisegundos)."
  type        = number
}

variable "error_threshold" {
  description = "Umbral de errores para alarmas (porcentaje)."
  type        = number
}

variable "cpu_threshold" {
  description = "Umbral de utilización de CPU para alarmas (porcentaje)."
  type        = number
}

variable "memory_threshold" {
  description = "Umbral de utilización de memoria para alarmas (porcentaje)."
  type        = number
}

variable "sns_topic_arn" {
  description = "ARN del topic SNS para notificaciones de alarmas."
  type        = string
}

variable "evaluation_periods" {
  description = "Número de períodos de evaluación para las alarmas."
  type        = number
  default     = 2
}

variable "period" {
  description = "Duración de cada período de evaluación (segundos)."
  type        = number
  default     = 60
}

variable "statistic" {
  description = "Estadística utilizada para las métricas (Average, Sum, etc.)."
  type        = string
  default     = "Average"
}

variable "namespace" {
  description = "Namespace de CloudWatch para las métricas."
  type        = string
  default     = "AWS/ECS"
}

variable "alarm_actions" {
  description = "Lista de acciones a ejecutar cuando se dispara una alarma."
  type        = list(string)
  default     = []
}

variable "ok_actions" {
  description = "Lista de acciones a ejecutar cuando una alarma vuelve a OK."
  type        = list(string)
  default     = []
}

variable "insufficient_data_actions" {
  description = "Lista de acciones a ejecutar cuando una alarma tiene datos insuficientes."
  type        = list(string)
  default     = []
}

// === ARCHIVO: main.tf ===
terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ============================================================================
# CONFIGURACIÓN DE RED Y SEGURIDAD
# ============================================================================

# VPC principal donde se desplegarán todos los recursos
data "aws_vpc" "main" {
  default = var.vpc_id == "" ? true : false
  id      = var.vpc_id != "" ? var.vpc_id : null
}

# Subnets públicas para el ALB
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  tags = {
    Type = "public"
  }
}

# Subnets privadas para ECS y RDS
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
  tags = {
    Type = "private"
  }
}

# Security group para el cluster ECS
resource "aws_security_group" "ecs" {
  name        = "${var.project}-${var.environment}-ecs-sg"
  description = "Security group para el cluster ECS de Tomcat"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.main.cidr_block]
    description = "HTTP traffic from ALB"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "${var.project}-${var.environment}-ecs-sg"
    Environment = var.environment
    Project     = var.project
  }
}

# Security group para RDS
resource "aws_security_group" "rds" {
  name        = "${var.project}-${var.environment}-rds-sg"
  description = "Security group para la base de datos RDS"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs.id]
    description     = "PostgreSQL traffic from ECS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "${var.project}-${var.environment}-rds-sg"
    Environment = var.environment
    Project     = var.project
  }
}

# Security group para el ALB
resource "aws_security_group" "alb" {
  name        = "${var.project}-${var.environment}-alb-sg"
  description = "Security group para el Application Load Balancer"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP from internet"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS from internet"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = {
    Name        = "${var.project}-${var.environment}-alb-sg"
    Environment = var.environment
    Project     = var.project
  }
}

# ============================================================================
# CLUSTER ECS CON FARGATE PARA TOMCAT
# ============================================================================

module "tomcat_cluster" {
  source = "./modules/tomcat-cluster"

  cluster_name           = "${var.project}-tomcat-${var.environment}"
  environment            = var.environment
  project                = var.project
  vpc_id                 = data.aws_vpc.main.id
  subnet_ids             = data.aws_subnets.private.ids
  security_group_ids     = [aws_security_group.ecs.id]
  container_image        = var.tomcat_image
  container_port         = var.tomcat_container_port
  desired_count          = var.ecs_desired_count
  max_capacity           = var.ecs_max_capacity
  min_capacity           = var.ecs_min_capacity
  cpu_threshold          = var.ecs_cpu_threshold
  memory_threshold       = var.ecs_memory_threshold
  alb_target_group_arn   = module.load_balancer.target_group_arns[0]
  alb_security_groups    = [aws_security_group.alb.id]
}

# ============================================================================
# BASE DE DATOS RDS POSTGRESQL
# ============================================================================

module "rds_postgresql" {
  source = "./modules/rds-postgresql"

  identifier     = "${var.project}-${var.environment}-db"
  environment    = var.environment
  project        = var.project
  engine         = "postgres"
  engine_version = var.rds_engine_version
  instance_class = var.rds_instance_class
  allocated_storage     = var.rds_allocated_storage
  storage_encrypted     = var.rds_storage_encrypted
  multi_az              = var.rds_multi_az
  db_name          = var.rds_db_name
  username        = var.rds_username
  password        = var.rds_password
  subnet_ids      = data.aws_subnets.private.ids
  security_group_ids = [aws_security_group.rds.id]
  backup_retention_period = var.rds_backup_retention
  skip_final_snapshot     = var.environment != "prod"
  deletion_protection     = var.environment == "prod"
  maintenance_window      = var.rds_maintenance_window
  backup_window           = var.rds_backup_window
}

# ============================================================================
# APPLICATION LOAD BALANCER
# ============================================================================

module "load_balancer" {
  source = "./modules/load-balancer"

  name           = "${var.project}-${var.environment}-alb"
  environment    = var.environment
  project        = var.project
  vpc_id         = data.aws_vpc.main.id
  subnet_ids     = data.aws_subnets.public.ids
  security_groups = [aws_security_group.alb.id]

  enable_http2   = true
  idle_timeout   = 60

  target_groups = [{
    name                             = "tomcat-target-group"
    port                             = 8080
    protocol                         = "HTTP"
    path_pattern                     = ["/*"]
    health_check_path                = var.health_check_path
    health_check_interval            = 30
    health_check_timeout             = 5
    healthy_threshold_count          = 2
    unhealthy_threshold_count        = 3
    target_type                      = "ip"
  }]

  listeners = [{
    port            = 80
    protocol        = "HTTP"
    target_group_index = 0
  }]

  tags = {
    Name        = "${var.project}-${var.environment}-alb"
    Environment = var.environment
    Project     = var.project
  }
}

# ============================================================================
# MONITOREO CON CLOUDWATCH
# ============================================================================

module "monitoring" {
  source = "./modules/monitoring"

  environment        = var.environment
  project            = var.project
  alb_arn            = module.load_balancer.arn
  alb_name           = module.load_balancer.name
  ecs_cluster_name   = module.tomcat_cluster.cluster_name
  ecs_service_name   = module.tomcat_cluster.service_name
  rds_instance_id    = module.rds_postgresql.instance_id
  rds_endpoint       = module.rds_postgresql.endpoint

  # Alarmas para el ALB
  alb_target_response_time_threshold = var.alb_response_time_threshold
  alb_target_error_rate_threshold    = var.alb_error_rate_threshold
  alb_request_count_threshold        = var.alb_request_count_threshold

  # Alarmas para ECS
  ecs_cpu_utilization_threshold  = var.ecs_cpu_threshold
  ecs_memory_utilization_threshold = var.ecs_memory_threshold
  ecs_service_running_count_threshold = var.ecs_desired_count

  # Alarmas para RDS
  rds_cpu_utilization_threshold     = var.rds_cpu_threshold
  rds_storage_utilization_threshold = var.rds_storage_threshold
  rds_connections_threshold         = var.rds_connections_threshold

  # Alarmas para costos
  enable_cost_alarms = var.environment != "dev"
  monthly_budget_limit = var.monthly_budget

  notification_topic_arn = var.sns_topic_arn
}

// === ARCHIVO: outputs.tf ===
# ============================================================================
# OUTPUTS DEL PROYECTO - Valores generados por la infraestructura
# ============================================================================

# Outputs del Cluster ECS
output "ecs_cluster_id" {
  description = "ID del cluster ECS"
  value       = module.tomcat_cluster.cluster_id
}

output "ecs_cluster_name" {
  description = "Nombre del cluster ECS"
  value       = module.tomcat_cluster.cluster_name
}

output "ecs_cluster_arn" {
  description = "ARN del cluster ECS"
  value       = module.tomcat_cluster.cluster_arn
}

output "ecs_service_name" {
  description = "Nombre del servicio ECS"
  value       = module.tomcat_cluster.service_name
}

output "ecs_task_definition_arn" {
  description = "ARN de la tarea ECS"
  value       = module.tomcat_cluster.task_definition_arn
}

output "ecs_container_name" {
  description = "Nombre del contenedor Tomcat"
  value       = module.tomcat_cluster.container_name
}

# Outputs de RDS
output "rds_instance_id" {
  description = "ID de la instancia RDS"
  value       = module.rds_postgresql.instance_id
}

output "rds_endpoint" {
  description = "Endpoint de conexión a la base de datos"
  value       = module.rds_postgresql.endpoint
  sensitive   = true
}

output "rds_arn" {
  description = "ARN de la instancia RDS"
  value       = module.rds_postgresql.instance_arn
}

output "rds_port" {
  description = "Puerto de la base de datos"
  value       = module.rds_postgresql.port
}

output "rds_db_name" {
  description = "Nombre de la base de datos"
  value       = module.rds_postgresql.db_name
}

output "rds_multi_az" {
  description = "Indicador de configuración multi-AZ"
  value       = module.rds_postgresql.multi_az
}

# Outputs del Load Balancer
output "alb_arn" {
  description = "ARN del Application Load Balancer"
  value       = module.load_balancer.arn
}

output "alb_name" {
  description = "Nombre del ALB"
  value       = module.load_balancer.name
}

output "alb_dns_name" {
  description = "DNS name del ALB para acceso externo"
  value       = module.load_balancer.dns_name
}

output "alb_zone_id" {
  description = "Zone ID del ALB para Route 53"
  value       = module.load_balancer.zone_id
}

output "alb_target_group_arn" {
  description = "ARN del target group de Tomcat"
  value       = module.load_balancer.target_group_arns[0]
}

output "alb_listener_arns" {
  description = "ARNs de los listeners del ALB"
  value       = module.load_balancer.listener_arns
}

# Outputs de Monitoreo
output "cloudwatch_log_group_name" {
  description = "Nombre del grupo de logs de CloudWatch"
  value       = module.monitoring.log_group_name
}

output "cloudwatch_log_group_arn" {
  description = "ARN del grupo de logs de CloudWatch"
  value       = module.monitoring.log_group_arn
}

output "sns_topic_arn" {
  description = "ARN del topic SNS para notificaciones de alarmas"
  value       = module.monitoring.sns_topic_arn
}

# Outputs de seguridad
output "ecs_security_group_id" {
  description = "ID del security group del cluster ECS"
  value       = aws_security_group.ecs.id
}

output "rds_security_group_id" {
  description = "ID del security group de RDS"
  value       = aws_security_group.rds.id
}

output "alb_security_group_id" {
  description = "ID del security group del ALB"
  value       = aws_security_group.alb.id
}

# Outputs de red
output "vpc_id" {
  description = "ID de la VPC utilizada"
  value       = data.aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block de la VPC"
  value       = data.aws_vpc.main.cidr_block
}

output "private_subnet_ids" {
  description = "IDs de las subnets privadas"
  value       = data.aws_subnets.private.ids
}

output "public_subnet_ids" {
  description = "IDs de las subnets públicas"
  value       = data.aws_subnets.public.ids
}

// === ARCHIVO: backend.tf ===
# ============================================================================
# CONFIGURACIÓN DEL BACKEND REMOTO
# ============================================================================
# El estado de Terraform se almacena en S3 con bloqueo de estado mediante
# DynamoDB para garantizar consistencia en despliegues concurrentes.
# Esta configuración es esencial para entornos de producción donde múltiples
# desarrolladores o pipelines pueden ejecutar Terraform simultáneamente.
# ============================================================================

terraform {
  backend "s3" {
    bucket         = "${var.project}-${var.environment}-terraform-state"
    key            = "infrastructure/terraform.tfstate"
    region         = var.aws_region
    encrypt        = true
    dynamodb_table = "${var.project}-${var.environment}-terraform-lock"

    # Configuración de versioning del bucket S3 para historial de estados
    versioning = true

    # Tabla DynamoDB para bloqueo de estado:
    # - Primary key: LockID (composite de terraform-state-id + unique-id)
    # - Atributos: Info (JSON con detalles del lock), Who (usuario que lockea)
    # -TTL en campo expires para auto-limpieza de locks antiguos
  }
}

# Recurso para crear la tabla DynamoDB de bloqueo si no existe
# Esta tabla debe existir antes de poder usar el backend S3
resource "aws_dynamodb_table" "terraform_lock" {
  name         = "${var.project}-${var.environment}-terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  ttl {
    attribute_name = "expires"
    enabled        = true
  }

  tags = {
    Name        = "${var.project}-${var.environment}-terraform-lock"
    Environment = var.environment
    Project     = var.project
    Purpose     = "Terraform State Locking"
  }
}

# Bucket S3 para almacenar el estado de Terraform
# Por defecto, el backend usa el bucket declarado en la configuración
# Esta es la versión declarativa del bucket para asegurar su existencia
resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.project}-${var.environment}-terraform-state"

  tags = {
    Name        = "${var.project}-${var.environment}-terraform-state"
    Environment = var.environment
    Project     = var.project
    Purpose     = "Terraform Remote State Storage"
  }
}

# Versioning del bucket para mantener historial de estados
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Encriptación del bucket con AWS KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Bloqueo público del bucket - Terraform state nunca debe ser público
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Política de acceso al bucket para el proveedor AWS
# Solo permite acceso desde la cuenta y rol configurados
data "aws_iam_policy_document" "terraform_state_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}/*",
      "${aws_s3_bucket.terraform_state.arn}"
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["false"]
    }
  }

  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "${aws_s3_bucket.terraform_state.arn}"
    ]
  }
}

resource "aws_s3_bucket_policy" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  policy = data.aws_iam_policy_document.terraform_state_policy.json
}


// === ARCHIVO: README.md ===
# Plataforma de Banca en Línea - Infraestructura AWS

## Descripción del Proyecto

Este proyecto implementa la infraestructura como código para una plataforma de banca en línea que requiere alta disponibilidad, escalabilidad y rendimiento óptimo. El sistema está diseñado para manejar 5,000 solicitudes por segundo con una latencia máxima de 200ms y un tiempo de actividad del 99.9%.

## Topología de la Arquitectura

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              VPC Principal (10.0.0.0/16)                    │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                         Subredes Públicas                            │    │
│  │  ┌─────────────────┐              ┌─────────────────┐               │    │
│  │  │   Public Subnet │              │   Public Subnet │               │    │
│  │  │   AZ1 (us-east-1a)│            │  AZ2 (us-east-1b)│               │    │
│  │  │  ┌─────────────┐│              │  ┌─────────────┐│               │    │
│  │  │  │     ALB     ││              │  │     ALB     ││               │    │
│  │  │  │  (Frontend) ││              │  │  (Backend)  ││               │    │
│  │  │  └─────────────┘│              │  └─────────────┘│               │    │
│  │  └─────────────────┘              └─────────────────┘               │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                      Subredes Privadas                              │    │
│  │  ┌─────────────────┐              ┌─────────────────┐               │    │
│  │  │  Private Subnet │              │  Private Subnet │               │    │
│  │  │  AZ1 (us-east-1a)│            │  AZ2 (us-east-1b)│               │    │
│  │  │  ┌─────────────┐│              │  ┌─────────────┐│               │    │
│  │  │  │     ECS     ││              │  │     ECS     ││               │    │
│  │  │  │   Fargate   ││              │  │   Fargate   ││               │    │
│  │  │  │   Cluster   ││              │  │   Cluster   ││               │    │
│  │  │  │  ┌────────┐ ││              │  │  ┌────────┐ ││               │    │
│  │  │  │  │Tomcat │ ││              │  │  │Tomcat │ ││               │    │
│  │  │  │  │Tasks │ ││              │  │  │Tasks │ ││               │    │
│  │  │  │  └────────┘ ││              │  │  └────────┘ ││               │    │
│  │  │  └─────────────┘│              │  └─────────────┘│               │    │
│  │  └─────────────────┘              └─────────────────┘               │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                       Subredes de Datos                             │    │
│  │  ┌─────────────────┐              ┌─────────────────┐               │    │
│  │  │   Data Subnet   │              │   Data Subnet   │               │    │
│  │  │  AZ1 (us-east-1a)│            │  AZ2 (us-east-1b)│               │    │
│  │  │  ┌─────────────┐│              │  ┌─────────────┐│               │    │
│  │  │  │     RDS     ││◄────────────►│  │     RDS     ││               │    │
│  │  │  │ PostgreSQL  ││  Replicación │  │ PostgreSQL  ││               │    │
│  │  │  │   Primary   ││    Multi-AZ  │  │  Standby    ││               │    │
│  │  │  └─────────────┘│              │  └─────────────┘│               │    │
│  │  └─────────────────┘              └─────────────────┘               │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                     Servicios Compartidos                          │    │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌────────────┐   │    │
│  │  │  CloudWatch│  │     S3     │  │     IAM    │  │    ACM    │   │    │
│  │  │  Logs/Metrics│ │  State/Artif│ │  Policies   │  │  SSL Cert │   │    │
│  │  └────────────┘  └────────────┘  └────────────┘  └────────────┘   │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Componentes de la Infraestructura

### Módulos Terraform

| Módulo | Propósito | Recursos Principales |
|--------|-----------|---------------------|
| `modules/vpc` | Networking | VPC, Subnets, NAT Gateway, Internet Gateway, Route Tables |
| `modules/tomcat-cluster` | Computo | ECS Cluster, Fargate Tasks, Auto Scaling Group, Service Discovery |
| `modules/rds-postgresql` | Base de datos | RDS Instance, DB Subnet Group, DB Security Group, Multi-AZ |
| `modules/load-balancer` | Balanceador | ALB, Target Groups, Listeners, SSL Certificate |
| `modules/monitoring` | Observabilidad | CloudWatch Logs, Metrics, Alarms, Dashboards |

## Comandos de Despliegue

### Prerrequisitos

```bash
# Instalar Terraform 1.7+
brew install terraform

# Configurar credenciales AWS
aws configure

# Verificar configuración
aws sts get-caller-identity
```

### Flujo de Despliegue por Ambiente

```bash
# =============================================================================
# AMBIENTE: DESARROLLO (dev)
# =============================================================================

# 1. Inicializar Terraform
cd environments/dev
terraform init -backend-config=backend.hcl

# 2. Validar configuración
terraform validate

# 3. Revisar plan de ejecución
terraform plan -var-file=terraform.tfvars

# 4. Aplicar cambios (confirmar con "yes")
terraform apply -var-file=terraform.tfvars

# 5. Destruir recursos (cuando sea necesario)
terraform destroy -var-file=terraform.tfvars

# =============================================================================
# AMBIENTE: QA
# =============================================================================

cd environments/qa
terraform init -backend-config=backend.hcl
terraform validate
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars

# =============================================================================
# AMBIENTE: PRODUCCIÓN (prod)
# =============================================================================

cd environments/prod
terraform init -backend-config=backend.hcl
terraform validate
terraform plan -var-file=terraform.tfvars
# Producción requiere aprobación manual
terraform apply -var-file=terraform.tfvars
```

### Verificación Post-Despliegue

```bash
# Verificar estado de los recursos
terraform state list

# Obtener outputs
terraform output

# Verificar conectividad al ALB
aws elbv2 describe-load-balancers --names ${ALB_NAME}

# Verificar estado de tareas ECS
aws ecs describe-services --cluster ${CLUSTER_NAME} --services ${SERVICE_NAME}

# Verificar métricas de CloudWatch
aws cloudwatch get-metric-statistics --namespace AWS/ECS --metric-name CPUUtilization
```

## Decisiones Arquitectónicas

### 1. ECS Fargate vs EC2

**Decisión**: Utilizar ECS con Fargate en lugar de EC2.

**Justificación**:
- Elimina la gestión de servidores y capacidad de infraestructura
- Escalado automático basado en métricas sin intervención manual
- Solo se paga por los recursos de contenedor utilizados
- Cumplimiento de requisitos de recuperación automática
- Integración nativa con Application Load Balancer

### 2. RDS Multi-AZ con PostgreSQL

**Decisión**: Implementar RDS PostgreSQL con replicación Multi-AZ.

**Justificación**:
- Failover automático en caso de fallo de la AZ primaria
- Backups automatizados con retención configurable
- Read replicas para distribución de carga de lectura
- Cifrado en reposo con KMS y en tránsito con SSL
- Cumplimiento de RTO < 5 minutos y RPO < 1 minuto

### 3. Application Load Balancer

**Decisión**: Utilizar ALB en lugar de NLB.

**Justificación**:
- Soporte para routing basado en contenido (host-based, path-based)
- Integración con AWS WAF para protección contra OWASP Top 10
- SSL/TLS termination centralizado con ACM
- Health checks configurables con múltiples endpoint
- sticky sessions para sesiones de usuario

### 4. Backend remoto con S3 y DynamoDB

**Decisión**: Estado remoto en S3 con bloqueo en DynamoDB.

**Justificación**:
- Colaboración segura entre múltiples equipos
- Previene conflictos en despliegues concurrentes
- Historial de versiones del estado
- Recuperación ante desastres con replicación de buckets

## Trade-offs Considerados

### Rendimiento vs Costo

| Aspecto | Decisión | Impacto |
|---------|----------|---------|
| Tipo de tarea ECS | Fargate | Mayor costo por hora pero sin overhead de servidor |
| Tamaño de instancia RDS | db.r6g.xlarge | Balance entre rendimiento y costo |
| NAT Gateway | Una por AZ | Costo adicional vs una sola NAT |

### Complejidad vs Velocidad de Despliegue

| Aspecto | Decisión | Impacto |
|---------|----------|---------|
| Módulos personalizados | Sí | Mayor flexibilidad pero más código |
| Pipelines CI/CD | Externo | Despliegue más rápido pero configuración adicional |
| Infrastructure Testing | Terratest | Mayor confianza pero mayor tiempo de desarrollo |

### Disponibilidad vs Costo

| Aspecto | Decisión | Impacto |
|---------|----------|---------|
| Multi-AZ | Obligatorio | Costo duplicado pero 99.9% uptime |
| Read Replicas | Opcional | Costo adicional para escalar lecturas |
| Backups | Diario con retención 30 días | Costo de almacenamiento adicional |

## Parámetros por Ambiente

### Desarrollo (dev)

- Instancias: 2 tareas ECS (mínimo), 4 (máximo)
- Base de datos: db.t3.medium
- Retención de logs: 7 días
- Alarmas: Solo críticas

### QA (qa)

- Instancias: 2 tareas ECS (mínimo), 6 (máximo)
- Base de datos: db.r6g.large
- Retención de logs: 14 días
- Alarmas: Críticas y advertencias

### Producción (prod)

- Instancias: 4 tareas ECS (mínimo), 20 (máximo)
- Base de datos: db.r6g.xlarge (Multi-AZ)
- Retención de logs: 30 días
- Alarmas: Todas las métricas
- Auto Scaling: Política de escalado basada en CPU y memoria

## Seguridad Implementada

### Red

- VPC con CIDR 10.0.0.0/16
- Subnets en múltiples AZs
- NAT Gateway para tráfico saliente
- Security Groups con reglas mínimas necesarias
- ALB accesible solo desde Internet (HTTP/HTTPS)

### Datos

- Cifrado en reposo con AWS KMS
- Cifrado en tránsito con SSL/TLS
- Parámetros sensibles en AWS Systems Manager Parameter Store
- Rotación automática de credenciales de base de datos

### Identidad

- Roles IAM con principio de menor privilegio
- Políticas específicas por componente
- MFA requerido para operaciones sensibles
- CloudTrail para auditoría de operaciones

## Monitoreo y Observabilidad

### Métricas Recolectadas

- CPU y memoria de tareas ECS
- Latencia de requests del ALB
- Count de errores 5xx y 4xx
- Conexiones a base de datos
- Métricas personalizadas de aplicación

### Alarmas Configuradas

| Alerta | Condición | Acción |
|--------|-----------|--------|
| Alta latencia ALB | p99 > 200ms | Notificación SNS |
| Errors elevados | 5xx > 1% | Escalado automático |
| CPUECS | > 80% por 5 min | Escalado automático |
| RDS CPU | > 75% por 5 min | Notificación SNS |
| RDS Storage | > 85% | Notificación SNS |

## Recuperación ante Desastres

### RTO y RPO Objetivo

- **RTO** (Recovery Time Objective): < 5 minutos
- **RPO** (Recovery Point Objective): < 1 minuto

### Estrategias Implementadas

- Multi-AZ para base de datos
- Auto Healing en servicios ECS
- ALB con health checks automáticos
- Backups automatizados con Point-in-Time Recovery
- Procedimientos de recuperación documentados

## Estructura de Archivos

```
.
├── README.md
├── backend.tf
├── outputs.tf
├── providers.tf
├── variables.tf
├── main.tf
├── environments/
│   ├── dev/
│   │   ├── backend.hcl
│   │   └── terraform.tfvars
│   ├── qa/
│   │   ├── backend.hcl
│   │   └── terraform.tfvars
│   └── prod/
│       ├── backend.hcl
│       └── terraform.tfvars
└── modules/
    ├── vpc/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── tomcat-cluster/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── rds-postgresql/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── load-balancer/
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    └── monitoring/
        ├── main.tf
        ├── outputs.tf
        └── variables.tf
```

## Mantenimiento y Operaciones

### Tareas de Mantenimiento Programado

1. **Semanal**: Revisión de métricas de CloudWatch
2. **Mensual**: Rotación de credenciales
3. **Trimestral**: Revisión de políticas IAM
4. **Anual**: Prueba de recuperación ante desastres

### Procedimiento de Escalado

1. Monitorear métricas en CloudWatch Dashboard
2. Identificar bottleneck (CPU, memoria, base de datos)
3. Ajustar políticas de auto-scaling si es necesario
4. Aplicar cambios con Terraform
5. Verificar mejora en métricas

## Referencias

- [Documentación de AWS ECS](https://docs.aws.amazon.com/ecs/)
- [Documentación de AWS RDS](https://docs.aws.amazon.com/rds/)
- [Terraform AWS Modules](https://registry.terraform.io/modules/terraform-aws-modules)
- [Best Practices de Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)


// === ARCHIVO: modules/tomcat-cluster/main.tf ===
terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  name_prefix   = var.prefix != "" ? "${var.prefix}-${var.service_name}" : var.service_name
  common_tags = merge(
    var.common_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Service     = var.service_name
    }
  )

  container_definitions = [
    {
      name      = var.service_name
      image     = var.container_image
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]
      environment = concat(
        [
          { name = "JAVA_OPTS", value = var.java_opts },
          { name = "CATALINA_OPTS", value = var.catalina_opts },
          { name = "SERVER_PORT", value = tostring(var.container_port) },
          { name = "APP_ENV", value = var.environment }
        ],
        var.extra_environment
      )
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${local.name_prefix}"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f http://localhost:${var.container_port}${var.health_check_path} || exit 1"]
        interval    = var.health_check_interval
        timeout     = var.health_check_timeout
        retries     = var.health_check_retries
        startPeriod = var.health_check_start_period
      }
      resources = {
        limits = {
          cpu    = var.task_cpu
          memory = var.task_memory
        }
        reservations = {
          cpu    = var.task_cpu_reservation
          memory = var.task_memory_reservation
        }
      }
    }
  ]
}

resource "aws_ecs_cluster" "this" {
  name = local.name_prefix

  setting {
    name  = "containerInsights"
    value = var.enable_container_insights ? "enabled" : "disabled"
  }

  configuration {
    execute_command_configuration {
      logging = "DEFAULT"
    }
  }

  tags = local.common_tags
}

resource "aws_ecs_cluster_capacity_providers" "this" {
  cluster = aws_ecs_cluster.this.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base              = var.fargate_base_capacity
    weight            = var.fargate_weight
  }
}

resource "aws_ecs_task_definition" "this" {
  family                   = local.name_prefix
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = tostring(var.task_cpu)
  memory                   = tostring(var.task_memory)
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions    = jsonencode(local.container_definitions)

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = var.cpu_architecture
  }

  volume {
    name = "efs-volume"

    efs_volume_configuration {
      file_system_id          = var.efs_id
      root_directory          = var.efs_root_directory
      transit_encryption      = var.efs_transit_encryption
      access_point_id         = var.efs_access_point_id
      iam                     = var.efs_iam_authentication ? "ENABLED" : "DISABLED"
    }
  }

  tags = local.common_tags
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "${local.name_prefix}-ecs-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["ecs-tasks.amazonaws.com"]
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "ecs_execution_role_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "ecs_execution_role_secrets" {
  count = length(var.secrets) > 0 ? 1 : 0
  name  = "${local.name_prefix}-ecs-execution-secrets"
  role  = aws_iam_role.ecs_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "ssm:GetParameters"
        ]
        Resource = var.secrets
      }
    ]
  })
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${local.name_prefix}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["ecs-tasks.amazonaws.com"]
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy" "ecs_task_role_policy" {
  count = length(var.task_policy_arns) > 0 ? 1 : 0
  name  = "${local.name_prefix}-ecs-task-policy"
  role  = aws_iam_role.ecs_task_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = ["sts:AssumeRole"]
        Resource = var.task_policy_arns
      }
    ]
  })
}

resource "aws_ecs_service" "this" {
  name            = local.name_prefix
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  launch_type     = "FARGATE"
  platform_version = var.platform_version

  desired_count = var.desired_count

  deployment_configuration {
    minimum_healthy_percent = var.minimum_healthy_percent
    maximum_percent         = var.maximum_percent

    deployment_circuit_breaker {
      enable   = var.enable_circuit_breaker
      rollback = var.circuit_breaker_rollback
    }
  }

  network_configuration {
    subnets          = var.vpc_subnet_ids
    security_groups  = var.security_groups
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  service_connect_configuration {
    enabled = var.enable_service_connect

    service {
      discovery_name = var.service_name
      port_name      = "${var.service_name}-port"

      client_alias {
        dns_name = var.service_name
        port     = var.container_port
      }
    }
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  tags = local.common_tags
}

resource "aws_appautoscaling_target" "ecs_target" {
  min_capacity = var.min_capacity
  max_capacity = var.max_capacity

  role_arn = aws_iam_role.autoscaling_role.arn

  scalable_dimension = "ecs:service:DesiredCount"
  resource_id         = "service/${aws_ecs_cluster.this.name}/${aws_ecs_service.this.name}"
  service_namespace   = "ecs"
}

resource "aws_appautoscaling_policy" "cpu_scaling" {
  name               = "${local.name_prefix}-cpu-scaling"
  scaling_target_id = aws_appautoscaling_target.ecs_target.id

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value       = var.cpu_target_value
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
}

resource "aws_appautoscaling_policy" "memory_scaling" {
  name               = "${local.name_prefix}-memory-scaling"
  scaling_target_id = aws_appautoscaling_target.ecs_target.id

  policy_type = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = var.memory_target_value
    scale_in_cooldown  = var.scale_in_cooldown
    scale_out_cooldown = var.scale_out_cooldown
  }
}

resource "aws_iam_role" "autoscaling_role" {
  name = "${local.name_prefix}-autoscaling-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["application-autoscaling.amazonaws.com"]
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "autoscaling_policy" {
  role       = aws_iam_role.autoscaling_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/ecs/${local.name_prefix}"
  retention_in_days = var.log_retention_days

  tags = local.common_tags
}

resource "aws_security_group" "ecs_tasks" {
  name        = "${local.name_prefix}-tasks-sg"
  description = "Security group for ECS tasks"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.container_port
    to_port     = var.container_port
    protocol    = "tcp"
    security_groups = var.allowed_security_groups
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}

resource "aws_security_group_rule" "alb_to_ecs" {
  type                     = "ingress"
  from_port                = var.container_port
  to_port                  = var.container_port
  protocol                 = "tcp"
  source_security_group_id = var.alb_security_group_id
  security_group_id        = aws_security_group.ecs_tasks.id
  description              = "Allow traffic from ALB to ECS tasks"
}

// === ARCHIVO: modules/tomcat-cluster/outputs.tf ===
output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.this.name
}

output "ecs_cluster_arn" {
  description = "ARN of the ECS cluster"
  value       = aws_ecs_cluster.this.arn
}

output "ecs_cluster_id" {
  description = "ID of the ECS cluster"
  value       = aws_ecs_cluster.this.id
}

output "ecs_service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.this.name
}

output "ecs_service_arn" {
  description = "ARN of the ECS service"
  value       = aws_ecs_service.this.arn
}

output "ecs_task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.this.arn
}

output "ecs_execution_role_arn" {
  description = "ARN of the ECS execution role"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "ARN of the ECS task role"
  value       = aws_iam_role.ecs_task_role.arn
}

output "autoscaling_role_arn" {
  description = "ARN of the autoscaling role"
  value       = aws_iam_role.autoscaling_role.arn
}

output "security_group_id" {
  description = "ID of the security group for ECS tasks"
  value       = aws_security_group.ecs_tasks.id
}

output "log_group_name" {
  description = "Name of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.this.name
}

output "log_group_arn" {
  description = "ARN of the CloudWatch log group"
  value       = aws_cloudwatch_log_group.this.arn
}

output "min_capacity" {
  description = "Minimum capacity for autoscaling"
  value       = var.min_capacity
}

output "max_capacity" {
  description = "Maximum capacity for autoscaling"
  value       = var.max_capacity
}

output "desired_count" {
  description = "Desired count of tasks"
  value       = aws_ecs_service.this.desired_count
}

// === ARCHIVO: modules/rds-postgresql/main.tf ===
terraform {
  required_version = ">= 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  name_prefix   = var.prefix != "" ? "${var.prefix}-${var.db_instance_name}" : var.db_instance_name
  common_tags = merge(
    var.common_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Component   = "database"
      Engine      = "postgresql"
    }
  )

  final_snapshot_identifier = var.skip_final_snapshot ? null : "${local.name_prefix}-final-snapshot-${formatdate("YYYYMMDD", timestamp())}"
}

resource "aws_db_subnet_group" "this" {
  name       = local.name_prefix
  subnet_ids = var.vpc_subnet_ids

  tags = local.common_tags
}

resource "aws_security_group" "rds" {
  name        = "${local.name_prefix}-sg"
  description = "Security group for RDS PostgreSQL instance"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    cidr_blocks     = var.allowed_cidr_blocks
    description     = "PostgreSQL access from allowed CIDRs"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = local.common_tags
}

resource "aws_db_instance" "this" {
  identifier = local.name_prefix

  engine                   = "postgres"
  engine_version           = var.engine_version
  instance_class           = var.instance_class
  allocated_storage        = var.allocated_storage
  max_allocated_storage    = var.max_allocated_storage
  storage_type             = var.storage_type
  storage_encrypted        = var.storage_encrypted

  db_name  = var.db_name
  username = var.master_username
  password = var.master_password
  port     = var.db_port

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = concat([aws_security_group.rds.id], var.extra_security_group_ids)

  multi_az = var.enable_multi_az ? var.db_hosted_zone_id != "" ? var.db_hosted_zone_id : "${var.availability_zones[0]}" : ""

  backup_retention_period = var.backup_retention_days
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  skip_final_snapshot       = var.skip_final_snapshot
  final_snapshot_identifier = local.final_snapshot_identifier

  copy_tags_to_snapshot   = var.copy_tags_to_snapshot
  delete_automated_backups = var.delete_automated_backups
  deletion_protection      = var.deletion_protection

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  performance_insights_enabled = var.enable_performance_insights
  performance_insights_kms_key_id = var.performance_insights_kms_key_arn

  monitoring_interval = var.enable_enhanced_monitoring ? var.monitoring_interval : 0
  monitoring_role_arn = var.enable_enhanced_monitoring ? aws_iam_role.rds_monitoring_role[0].arn : ""

  allow_major_version_upgrade = var.allow_major_version_upgrade
  auto_minor_version_upgrade  = var.auto_minor_version_upgrade
  apply_immediately           = var.apply_immediately

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [password]
  }

  tags = local.common_tags
}

resource "aws_iam_role" "rds_monitoring_role" {
  count = var.enable_enhanced_monitoring ? 1 : 0
  name  = "${local.name_prefix}-monitoring-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["monitoring.rds.amazonaws.com"]
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "rds_monitoring_policy" {
  count = var.enable_enhanced_monitoring ? 1 : 0
  role       = aws_iam_role.rds_monitoring_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

resource "aws_db_instance" "read_replica" {
  count = var.create_read_replica ? var.read_replica_count : 0

  identifier = "${local.name_prefix}-replica-${count.index}"

  engine                   = "postgres"
  engine_version           = var.engine_version
  instance_class           = var.read_replica_instance_class
  allocated_storage        = var.allocated_storage
  storage_type             = var.storage_type
  storage_encrypted        = var.storage_encrypted

  db_name  = var.db_name
  username = var.master_username
  password = var.master_password
  port     = var.db_port

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = concat([aws_security_group.rds.id], var.extra_security_group_ids)

  source_db_instance_identifier = aws_db_instance.this.identifier
  replicate_source_db           = aws_db_instance.this.identifier

  backup_retention_period = var.read_replica_backup_retention
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window

  skip_final_snapshot       = true
  copy_tags_to_snapshot     = var.copy_tags_to_snapshot
  deletion_protection       = var.read_replica_deletion_protection

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  monitoring_interval = var.enable_enhanced_monitoring ? var.monitoring_interval : 0
  monitoring_role_arn = var.enable_enhanced_monitoring ? aws_iam_role.rds_monitoring_role[0].arn : ""

  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  apply_immediately          = var.apply_immediately

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [password]
  }

  tags = merge(local.common_tags, { Replica = "true" })
}

resource "aws_rds_cluster_parameter_group" "this" {
  count = length(var.custom_parameters) > 0 ? 1 : 0

  name   = "${local.name_prefix}-params"
  family = "postgres${var.custom_parameter_family}"

  dynamic "parameter" {
    for_each = var.custom_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }

  tags = local.common_tags
}

resource "aws_kms_key" "rds" {
  count = var.storage_encrypted && var.create_kms_key ? 1 : 0

  description             = "KMS key for RDS ${local.name_prefix}"
  deletion_window_in_days = 10
  enable_key_rotation     = var.enable_key_rotation

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-policy"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          Service = ["rds.amazonaws.com"]
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey",
          "kms:CreateGrant"
        ]
        Resource = "*"
        Condition = {
          StringEquals = {
            "kms:CallerAccount" = [var.account_id]
          }
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_kms_alias" "rds" {
  count = var.storage_encrypted && var.create_kms_key ? 1 : 0

  name          = "alias/${local.name_prefix}-rds"
  target_key_id = aws_kms_key.rds[0].key_id
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization" {
  alarm_name          = "${local.name_prefix}-cpu-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.alarm_cpu_threshold
  alarm_description   = "This metric monitors RDS CPU utilization"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.alarm_actions

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.this.identifier
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "storage_utilization" {
  alarm_name          = "${local.name_prefix}-storage-utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = "StorageUtilization"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.alarm_storage_threshold
  alarm_description   = "This metric monitors RDS storage utilization"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.alarm_actions

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.this.identifier
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "connections" {
  alarm_name          = "${local_name_prefix}-connections"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.alarm_connections_threshold
  alarm_description   = "This metric monitors RDS database connections"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.alarm_actions

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.this.identifier
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "read_io" {
  count = var.create_read_replica ? var.read_replica_count : 0

  alarm_name          = "${local.name_prefix}-replica-${count.index}-read-io"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = "ReadIOPS"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.alarm_read_iops_threshold
  alarm_description   = "This metric monitors RDS read replica ReadIOPS"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.alarm_actions

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.read_replica[count.index].identifier
  }

  tags = local.common_tags
}

resource "aws_cloudwatch_metric_alarm" "write_io" {
  alarm_name          = "${local.name_prefix}-write-io"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = var.alarm_evaluation_periods
  metric_name         = "WriteIOPS"
  namespace           = "AWS/RDS"
  period              = var.alarm_period
  statistic           = "Average"
  threshold           = var.alarm_write_iops_threshold
  alarm_description   = "This metric monitors RDS WriteIOPS"
  alarm_actions       = var.alarm_actions
  ok_actions          = var.alarm_actions

  dimensions = {
    DBInstanceIdentifier = aws_db_instance.this.identifier
  }

  tags = local.common_tags
}

resource "aws_sns_topic" "rds_notifications" {
  count = var.create_sns_topic ? 1 : 0

  name = "${local.name_prefix}-notifications"

  tags = local.common_tags
}

resource "aws_rds_event_subscription" "this" {
  count = var.enable_event_subscription ? 1 : 0

  name          = "${local.name_prefix}-events"
  sns_topic_arn = aws_sns_topic.rds_notifications[0].arn

  source_type = "db-instance"

  event_categories = var.event_categories

  tags = local.common_tags
}


// === ARCHIVO: modules/rds-postgresql/outputs.tf ===
output "db_instance_endpoint" {
  description = "The connection endpoint for the RDS database instance"
  value       = module.rds.db_instance_endpoint
}

output "db_instance_address" {
  description = "The address of the RDS database instance"
  value       = module.rds.db_instance_address
}

output "db_instance_arn" {
  description = "The ARN of the RDS database instance"
  value       = module.rds.db_instance_arn
}

output "db_instance_name" {
  description = "The name of the RDS database instance"
  value       = module.rds.db_instance_name
}

output "db_instance_port" {
  description = "The port of the RDS database instance"
  value       = module.rds.db_instance_port
}

output "db_instance_id" {
  description = "The ID of the RDS database instance"
  value       = module.rds.db_instance_id
}

output "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  value       = module.rds.db_subnet_group_name
}

output "security_group_id" {
  description = "The ID of the security group attached to RDS"
  value       = module.rds.security_group_id
}

output "db_enhanced_monitoring_iam_role_arn" {
  description = "The ARN of the IAM role for Enhanced Monitoring"
  value       = module.rds.enhanced_monitoring_iam_role_arn
}

output "db_parameter_group_id" {
  description = "The ID of the DB parameter group"
  value       = module.rds.db_parameter_group_id
}

output "db_option_group_id" {
  description = "The ID of the DB option group"
  value       = module.rds.db_option_group_id
}

output "db_master_user_secret_arn" {
  description = "The ARN of the secret containing the master user credentials"
  value       = module.rds.db_master_user_secret_arn
  sensitive   = true
}

// === ARCHIVO: modules/load-balancer/main.tf ===
locals {
  # Nombre del balanceador de carga derivado del ambiente
  lb_name = var.lb_name != "" ? var.lb_name : "${var.environment}-app-lb"

  # Configuracion de tags comunes para todos los recursos
  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "terraform"
    }
  )

  # Lista de subredes publicas para el ALB
  subnet_ids = var.create_public_subnets ? var.public_subnet_ids : []
}

# Modulo de Application Load Balancer usando el modulo oficial de AWS
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = local.lb_name

  # Configuracion de listeners HTTP y HTTPS
  listeners = [
    {
      port               = var.http_port
      protocol           = "HTTP"
      target_group_index = 0
    },
    {
      port               = var.https_port
      protocol           = "HTTPS"
      certificate_arn    = var.ssl_certificate_arn
      target_group_index = 0
      ssl_policy         = var.ssl_policy
    }
  ]

  # Configuracion de target groups para los servicios de aplicacion
  target_groups = [
    {
      name              = "${var.environment}-app-tg"
      backend_protocol  = "HTTP"
      backend_port      = var.target_group_port
      target_type       = var.target_type
      health_check = {
        enabled             = var.health_check_enabled
        healthy_threshold   = var.health_check_healthy_threshold
        unhealthy_threshold = var.health_check_unhealthy_threshold
        timeout             = var.health_check_timeout
        interval            = var.health_check_interval
        path                = var.health_check_path
        matcher             = var.health_check_matcher
      }
      # Configuracion de deregistration delay para graceful shutdown
      deregistration_delay = var.deregistration_delay
      # Slow start para evitar saturacion de nuevas instancias
      slow_start = var.slow_start
      # Protocolo de health check
      health_check_protocol = "HTTP"
    }
  ]

  # Vpc y subredes donde se desplegara el ALB
  vpc_id = var.vpc_id
  subnets = var.create_public_subnets ? var.public_subnet_ids : var.private_subnet_ids

  # Configuracion de seguridad del ALB
  enable_deletion_protection = var.enable_deletion_protection
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing
  enable_http2 = var.enable_http2
  enable_waf_fail_open = var.enable_waf_fail_open

  # Tipo de balanceador: application (capa 7)
  load_balancer_type = "application"

  # IP fija para el ALB (no soportada en ALB, se usa en NLB)
  # Esta configuracion es para compatibilidad con la interfaz

  # Configuracion de access logs
  access_logs = var.enable_access_logs ? {
    bucket  = var.log_bucket_name
    prefix  = var.log_prefix
    enabled = true
  } : {
    enabled = false
  }

  # Security group para el ALB que permite trafico entrante
  security_groups = [module.alb_security_group.security_group_id]

  # Tags aplicados a todos los recursos
  tags = local.common_tags
}

# Security group para el ALB
module "alb_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${local.lb_name}-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  # Permitir trafico HTTP desde cualquier lugar
  ingress_with_cidr_blocks = [
    {
      from_port   = var.http_port
      to_port     = var.http_port
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "HTTP access from anywhere"
    }
  ]

  # Permitir trafico HTTPS desde cualquier lugar
  ingress_with_cidr_blocks = [
    {
      from_port   = var.https_port
      to_port     = var.https_port
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
      description = "HTTPS access from anywhere"
    }
  ]

  # Permitir todo el trafico saliente
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      description = "Allow all outbound traffic"
    }
  ]

  tags = local.common_tags
}

# Reglas de routing avanzadas basadas en path o host
# Esto permite direccionar trafico a diferentes servicios
resource "aws_lb_listener_rule" "app_routing" {
  count = length(var.routing_rules) > 0 ? length(var.routing_rules) : 0

  listener_arn = module.alb.http_tcp_listener_arns[0]
  priority     = var.listener_priority + count

  action {
    type             = "forward"
    target_group_arn = module.alb.target_group_arns[0]
  }

  condition {
    path_pattern {
      values = [var.routing_rules[count].path_pattern]
    }
  }

  tags = local.common_tags
}

# Regla de redirect para HTTP a HTTPS
resource "aws_lb_listener_rule" "http_to_https_redirect" {
  count = var.enable_http_to_https_redirect ? 1 : 0

  listener_arn = module.alb.http_tcp_listener_arns[0]
  priority     = var.listener_priority

  action {
    type = "redirect"

    redirect {
      port        = var.https_port
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  tags = local.common_tags
}

# === ARCHIVO: modules/load-balancer/outputs.tf ===
output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = module.alb.arn
}

output "alb_arn_suffix" {
  description = "The ARN suffix of the Application Load Balancer"
  value       = module.alb.arn_suffix
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = module.alb.dns_name
}

output "alb_zone_id" {
  description = "The zone ID of the Application Load Balancer"
  value       = module.alb.zone_id
}

output "alb_id" {
  description = "The ID of the Application Load Balancer"
  value       = module.alb.id
}

output "alb_name" {
  description = "The name of the Application Load Balancer"
  value       = module.alb.name
}

output "alb_security_group_id" {
  description = "The ID of the security group attached to the ALB"
  value       = module.alb_security_group.security_group_id
}

output "alb_security_group_arn" {
  description = "The ARN of the security group attached to the ALB"
  value       = module.alb_security_group.security_group_arn
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = module.alb.target_group_arns[0]
}

output "target_group_name" {
  description = "The name of the target group"
  value       = module.alb.target_group_names[0]
}

output "target_group_id" {
  description = "The ID of the target group"
  value       = module.alb.target_group_ids[0]
}

output "http_listener_arn" {
  description = "The ARN of the HTTP listener"
  value       = module.alb.http_tcp_listener_arns[0]
}

output "https_listener_arn" {
  description = "The ARN of the HTTPS listener"
  value       = module.alb.https_listener_arns[0]
}

output "http_listener_id" {
  description = "The ID of the HTTP listener"
  value       = module.alb.http_tcp_listener_ids[0]
}

output "https_listener_id" {
  description = "The ID of the HTTPS listener"
  value       = module.alb.https_listener_ids[0]
}

output "access_logs_bucket" {
  description = "The name of the S3 bucket for access logs"
  value       = var.enable_access_logs ? var.log_bucket_name : null
}

output "security_group_name" {
  description = "The name of the ALB security group"
  value       = module.alb_security_group.security_group_name
}

// === ARCHIVO: modules/monitoring/main.tf ===
locals {
  alarm_prefix        = "${var.project_name}-${var.environment}"
  dashboard_name      = "${var.project_name}-${var.environment}-dashboard"
  ecs_service_name    = var.ecs_cluster_name
  rds_instance_id     = var.rds_instance_id
}

resource "aws_cloudwatch_metric_alarm" "ecs_cpu_utilization_high" {
  alarm_name          = "${local.alarm_prefix}-ecs-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.ecs_cpu_threshold
  alarm_description   = "Alarma cuando la CPU del cluster ECS supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    ClusterName = local.ecs_service_name
  }

  tags = {
    Name        = "${local.alarm_prefix}-ecs-cpu-high"
    Environment = var.environment
    Component   = "ecs-cluster"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_memory_utilization_high" {
  alarm_name          = "${local.alarm_prefix}-ecs-memory-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.ecs_memory_threshold
  alarm_description   = "Alarma cuando la memoria del cluster ECS supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    ClusterName = local.ecs_service_name
  }

  tags = {
    Name        = "${local.alarm_prefix}-ecs-memory-high"
    Environment = var.environment
    Component   = "ecs-cluster"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_service_cpu_utilization_high" {
  count               = length(var.ecs_service_names)
  alarm_name          = "${local.alarm_prefix}-ecs-service-cpu-high-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.ecs_service_cpu_threshold
  alarm_description   = "Alarma cuando la CPU del servicio ECS ${count.index} supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    ClusterName = local.ecs_service_name
    ServiceName = var.ecs_service_names[count.index]
  }

  tags = {
    Name        = "${local.alarm_prefix}-ecs-service-cpu-high"
    Environment = var.environment
    Component   = "ecs-service"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_service_memory_utilization_high" {
  count               = length(var.ecs_service_names)
  alarm_name          = "${local.alarm_prefix}-ecs-service-memory-high-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.ecs_service_memory_threshold
  alarm_description   = "Alarma cuando la memoria del servicio ECS ${count.index} supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    ClusterName = local.ecs_service_name
    ServiceName = var.ecs_service_names[count.index]
  }

  tags = {
    Name        = "${local.alarm_prefix}-ecs-service-memory-high"
    Environment = var.environment
    Component   = "ecs-service"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_running_tasks_low" {
  alarm_name          = "${local.alarm_prefix}-ecs-running-tasks-low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "RunningTaskCount"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = var.ecs_min_running_tasks
  alarm_description   = "Alarma cuando el número de tareas运行低于 el mínimo"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    ClusterName = local.ecs_service_name
  }

  tags = {
    Name        = "${local.alarm_prefix}-ecs-running-tasks-low"
    Environment = var.environment
    Component   = "ecs-cluster"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_cpu_utilization_high" {
  alarm_name          = "${local.alarm_prefix}-rds-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_cpu_threshold
  alarm_description   = "Alarma cuando la CPU de RDS supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-cpu-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_memory_utilization_high" {
  alarm_name          = "${local.alarm_prefix}-rds-memory-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "FreeableMemory"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_free_memory_threshold
  alarm_description   = "Alarma cuando la memoria libre de RDS está por debajo del umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-memory-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_storage_utilization_high" {
  alarm_name          = "${local.alarm_prefix}-rds-storage-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "DiskQueueDepth"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_storage_threshold
  alarm_description   = "Alarma cuando el almacenamiento de RDS supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-storage-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_connections_high" {
  alarm_name          = "${local.alarm_prefix}-rds-connections-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "DatabaseConnections"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_connections_threshold
  alarm_description   = "Alarma cuando las conexiones a RDS superan el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-connections-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_read_iops_high" {
  alarm_name          = "${local.alarm_prefix}-rds-read-iops-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "ReadIOPS"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_read_iops_threshold
  alarm_description   = "Alarma cuando los IOPS de lectura de RDS superan el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-read-iops-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_write_iops_high" {
  alarm_name          = "${local.alarm_prefix}-rds-write-iops-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "WriteIOPS"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_write_iops_threshold
  alarm_description   = "Alarma cuando los IOPS de escritura de RDS superan el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-write-iops-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_replica_lag_high" {
  count               = var.enable_read_replica ? 1 : 0
  alarm_name          = "${local.alarm_prefix}-rds-replica-lag-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "ReplicaLag"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Average"
  threshold           = var.rds_replica_lag_threshold
  alarm_description   = "Alarma cuando el lag de replicación de RDS supera el umbral"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-replica-lag-high"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_metric_alarm" "rds_failover_metric" {
  alarm_name          = "${local.alarm_prefix}-rds-failover"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Failover"
  namespace           = "AWS/RDS"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "Alarma cuando ocurre un failover en RDS"
  alarm_actions       = [var.sns_topic_arn]
  ok_actions          = [var.sns_topic_arn]

  dimensions = {
    DBInstanceIdentifier = local.rds_instance_id
  }

  tags = {
    Name        = "${local.alarm_prefix}-rds-failover"
    Environment = var.environment
    Component   = "rds-database"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_log_group" "ecs_application_logs" {
  count             = var.enable_application_logs ? 1 : 0
  name              = "/ecs/${var.project_name}/${var.environment}/application"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.logs_kms_key_arn
  tags = {
    Name        = "${local.alarm_prefix}-ecs-logs"
    Environment = var.environment
    Component   = "ecs-application"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_log_group" "ecs_audit_logs" {
  count             = var.enable_audit_logs ? 1 : 0
  name              = "/ecs/${var.project_name}/${var.environment}/audit"
  retention_in_days = var.log_retention_days
  kms_key_id        = var.logs_kms_key_arn
  tags = {
    Name        = "${local.alarm_prefix}-ecs-audit-logs"
    Environment = var.environment
    Component   = "ecs-audit"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_log_metric_filter" "ecs_error_filter" {
  count          = var.enable_application_logs ? 1 : 0
  name           = "${local.alarm_prefix}-ecs-errors"
  pattern        = "ERROR"
  log_group_name = aws_cloudwatch_log_group.ecs_application_logs[0].name

  metric_transformation {
    name      = "ErrorCount"
    namespace = "${var.project_name}/${var.environment}"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "ecs_errors_alarm" {
  count          = var.enable_application_logs ? 1 : 0
  alarm_name     = "${local.alarm_prefix}-ecs-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name    = "ErrorCount"
  namespace      = "${var.project_name}/${var.environment}"
  period         = 60
  statistic      = "Sum"
  threshold      = var.ecs_error_threshold
  alarm_description = "Alarma cuando se detectan errores en los logs de aplicación"
  alarm_actions  = [var.sns_topic_arn]
  ok_actions     = [var.sns_topic_arn]

  tags = {
    Name        = "${local.alarm_prefix}-ecs-errors"
    Environment = var.environment
    Component   = "ecs-application"
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_dashboard" "main_dashboard" {
  dashboard_name = local.dashboard_name

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ECS", "CPUUtilization", { stat = "Average" }],
            [".", "MemoryUtilization", { stat = "Average" }],
            [{" color = "#ff7f7f", label = "CPU %" }, ".", "CPUUtilization", { stat = "Maximum" }],
            [{" color = "#7f7fff", label = "Memory %" }, ".", "MemoryUtilization", { stat = "Maximum" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "ECS Cluster Resource Utilization"
          annotations = {
            horizontal = [
              { value = var.ecs_cpu_threshold, label = "CPU Threshold", color = "#ff0000" },
              { value = var.ecs_memory_threshold, label = "Memory Threshold", color = "#0000ff" }
            ]
          }
          yAxis = {
            left = { min = 0, max = 100 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ECS", "RunningTaskCount", { stat = "Maximum" }],
            ["AWS/ECS", "PendingTaskCount", { stat = "Maximum" }],
            ["AWS/ECS", "DesiredTaskCount", { stat = "Maximum" }]
          ]
          period = 60
          stat   = "Maximum"
          region = var.aws_region
          title  = "ECS Service Task Count"
          yAxis = {
            left = { min = 0 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "CPUUtilization", { stat = "Average" }],
            ["AWS/RDS", "ReadIOPS", { stat = "Average" }],
            ["AWS/RDS", "WriteIOPS", { stat = "Average" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "RDS Performance Metrics"
          annotations = {
            horizontal = [
              { value = var.rds_cpu_threshold, label = "CPU Threshold", color = "#ff0000" }
            ]
          }
          yAxis = {
            left = { min = 0, max = 100 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "DatabaseConnections", { stat = "Maximum" }],
            ["AWS/RDS", "FreeStorageSpace", { stat = "Minimum", label = "Free Storage (GB)" }]
          ]
          period = 60
          stat   = "Maximum"
          region = var.aws_region
          title  = "RDS Connections and Storage"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "TargetResponseTime", { stat = "p95", label = "p95 Response Time" }],
            ["AWS/ApplicationELB", "TargetResponseTime", { stat = "p99", label = "p99 Response Time" }],
            ["AWS/ApplicationELB", "TargetResponseTime", { stat = "Average", label = "Average Response Time" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "ALB Response Time"
          yAxis = {
            left = { min = 0 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "RequestCountPerTarget", { stat = "Sum", label = "Requests per Target" }],
            ["AWS/ApplicationELB", "HealthyHostCount", { stat = "Maximum", label = "Healthy Hosts" }],
            ["AWS/ApplicationELB", "UnhealthyHostCount", { stat = "Maximum", label = "Unhealthy Hosts", color = "#ff0000" }]
          ]
          period = 60
          stat   = "Sum"
          region = var.aws_region
          title  = "ALB Request Distribution"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/ApplicationELB", "HTTPCode_Target_5XX_Count", { stat = "Sum", color = "#ff0000", label = "5XX Errors" }],
            ["AWS/ApplicationELB", "HTTPCode_Target_4XX_Count", { stat = "Sum", color = "#ff8800", label = "4XX Errors" }],
            ["AWS/ApplicationELB", "HTTPCode_Target_2XX_Count", { stat = "Sum", color = "#00ff00", label = "2XX Success" }]
          ]
          period = 60
          stat   = "Sum"
          region = var.aws_region
          title  = "ALB HTTP Response Codes"
        }
      },
      {
        type = "log"
        properties = {
          query = "SOURCE '/ecs/${var.project_name}/${var.environment}/application' | filter @message like /ERROR/ | stats count() as ErrorCount by bin(1m)"
          region = var.aws_region
          title  = "Application Error Rate"
        }
      }
    ]
  })

  tags = {
    Name        = local.dashboard_name
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}

resource "aws_cloudwatch_dashboard" "rds_dashboard" {
  dashboard_name = "${local.dashboard_name}-rds"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "CPUUtilization", { stat = "Average" }],
            ["AWS/RDS", "CPUUtilization", { stat = "Maximum", color = "#ff0000" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "RDS CPU Utilization"
          annotations = {
            horizontal = [
              { value = var.rds_cpu_threshold, label = "Threshold", color = "#ff0000" }
            ]
          }
          yAxis = {
            left = { min = 0, max = 100 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "ReadIOPS", { stat = "Average", label = "Read IOPS" }],
            ["AWS/RDS", "WriteIOPS", { stat = "Average", label = "Write IOPS" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "RDS IOPS"
          yAxis = {
            left = { min = 0 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "DatabaseConnections", { stat = "Maximum" }],
            ["AWS/RDS", "DatabaseConnections", { stat = "Average" }]
          ]
          period = 60
          stat   = "Maximum"
          region = var.aws_region
          title  = "RDS Database Connections"
          annotations = {
            horizontal = [
              { value = var.rds_connections_threshold, label = "Threshold", color = "#ff0000" }
            ]
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "FreeStorageSpace", { stat = "Minimum", label = "Free Space (GB)" }]
          ]
          period = 60
          stat   = "Minimum"
          region = var.aws_region
          title  = "RDS Free Storage"
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "ReadLatency", { stat = "Average", label = "Read Latency (ms)" }],
            ["AWS/RDS", "WriteLatency", { stat = "Average", label = "Write Latency (ms)" }]
          ]
          period = 60
          stat   = "Average"
          region = var.aws_region
          title  = "RDS Latency"
          yAxis = {
            left = { min = 0 }
          }
        }
      },
      {
        type = "metric"
        properties = {
          metrics = [
            ["AWS/RDS", "ReplicaLag", { stat = "Maximum", color = "#ff0000" }]
          ]
          count  = var.enable_read_replica ? 1 : 0
          period = 60
          stat   = "Maximum"
          region = var.aws_region
          title  = "RDS Replica Lag"
          annotations = {
            horizontal = [
              { value = var.rds_replica_lag_threshold, label = "Threshold", color = "#ff0000" }
            ]
          }
        }
      }
    ]
  })

  count = var.enable_read_replica ? 1 : 0

  tags = {
    Name        = "${local.dashboard_name}-rds"
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "terraform"
  }
}


// === ARCHIVO: environments/dev/terraform.tfvars ===
# Configuración de variables para el ambiente de DESARROLLO
# Objetivo: Entorno de desarrollo con recursos mínimos para reducir costos
# Las instancias pequeñas permiten iteraciones rápidas sin costos elevados

# ============================================
# Configuración de Red y Entorno
# ============================================
environment             = "dev"
aws_region              = "us-east-1"
project_name            = "banking-platform"

# Tags obligatorios para identificación y costos
tags = {
  Environment     = "dev"
  Project         = "banking-platform"
  ManagedBy       = "terraform"
  CostCenter      = "it-development"
  ComplianceLevel = "dev"
}

# ============================================
# Configuración del Cluster Tomcat (ECS/Fargate)
# ============================================
tomcat_cluster = {
  # Instancia pequeña para desarrollo - t3.small es suficiente para pruebas
  instance_type = "t3.small"
  
  # Réplicas mínimas - solo 1 instancia para降低成本 en dev
  desired_capacity = 1
  min_capacity     = 1
  max_capacity     = 2
  
  # Configuración de escalado
  # En dev no necesitamos escalado agresivo
  scale_up_cooldown    = 300
  scale_down_cooldown  = 300
  
  # Umbrales de escalado (porcentage de CPU)
  # Umbrales más permisivos para ambiente de desarrollo
  scale_up_threshold   = 70
  scale_down_threshold = 30
  
  # Configuración de health check
  health_check_grace_period_seconds = 60
  
  # Timeout de tarea
  task_timeout_minutes = 10
}

# ============================================
# Configuración de Base de Datos RDS PostgreSQL
# ============================================
rds_postgresql = {
  # Instancia pequeña para desarrollo - db.t3.micro tiene recursos suficientes
  instance_class = "db.t3.micro"
  
  # Almacenamiento mínimo - 20GB es suficiente para desarrollo
  allocated_storage_gb = 20
  
  # Storage type gp3 para mejor rendimiento
  storage_type = "gp3"
  
  # Multi-AZ desactivado para development - reduce costos
  multi_az = false
  
  # Backup retention corto para development
  backup_retention_days = 1
  
  # Ventana de mantenimiento en horario no crítico
  maintenance_window = "sun:04:00-sun:05:00"
  
  # Backup window en horario no crítico
  backup_window = "03:00-04:00"
  
  # Eliminación automática desactivada para protección en dev
  deletion_protection = false
  
  # Performance Insights desactivado para reducir costos
  enable_performance_insights = false
  
  # Logging de errores únicamente
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
  
  # Parámetros de conexión
  max_connections = 100
  
  # Cifrado en reposo
  storage_encrypted = true
}

# ============================================
# Configuración del Load Balancer (ALB)
# ============================================
load_balancer = {
  # Protección contra eliminación activada por seguridad
  enable_deletion_protection = false
  
  # Timeout de inactividad reducido para desarrollo
  idle_timeout_seconds = 30
  
  # SSL no requerido en desarrollo
  enable_ssl = false
  
  # Access logs deshabilitados para reducir costos
  enable_access_logs = false
  
  # Cross-zone balancing activado
  enable_cross_zone_load_balancing = true
}

# ============================================
# Configuración de Monitoring y Alarmas
# ============================================
monitoring = {
  # Alarmas con umbrales más permisivos para desarrollo
  # No queremos alertas excesivas en entorno de desarrollo
  
  # Umbral de CPU - 80% para desarrollo
  cpu_alarm_threshold = 80
  
  # Umbral de memoria - 85%
  memory_alarm_threshold = 85
  
  # Umbral de latencia - 500ms (más permisivo que prod)
  latency_alarm_threshold_ms = 500
  
  # Umbral de errores - 5%
  error_rate_threshold = 5
  
  # ALB 5xx errors threshold
  alb_5xx_threshold = 10
  
  # Target response time threshold
  target_response_time_threshold = 1
  
  # Período de evaluación más corto para desarrollo
  evaluation_period_seconds = 300
  
  # Período de datos para alarma
  datapoints_to_alarm = 2
  
  # Slack channel para notificaciones (puede ser un canal de dev)
  notification_topic = "dev-alerts"
  
  # Dashboard detallado desactivado para reducir costos
  create_detailed_dashboard = false
}

# ============================================
# Configuración de Alta Disponibilidad
# ============================================
ha_config = {
  # Alta disponibilidad desactivada en desarrollo
  # Solo 1 AZ para reducir costos
  enable_multi_az = false
  
  # RTO objetivo en horas (desarrollo más permisivo)
  rto_hours = 4
  
  # RPO objetivo en horas
  rpo_hours = 1
  
  # Replicación de datos desactivada
  enable_replication = false
}

// === ARCHIVO: environments/qa/terraform.tfvars ===
# Configuración de variables para el ambiente de QA
# Objetivo: Validación de funcionalidad y rendimiento antes de producción
# Instancias medianas con configuración que simula producción a menor escala

# ============================================
# Configuración de Red y Entorno
# ============================================
environment             = "qa"
aws_region              = "us-east-1"
project_name            = "banking-platform"

# Tags obligatorios para identificación y costos
tags = {
  Environment     = "qa"
  Project         = "banking-platform"
  ManagedBy       = "terraform"
  CostCenter      = "it-quality-assurance"
  ComplianceLevel = "internal"
}

# ============================================
# Configuración del Cluster Tomcat (ECS/Fargate)
# ============================================
tomcat_cluster = {
  # Instancia mediana para QA - t3.medium para pruebas de carga
  instance_type = "t3.medium"
  
  # Réplicas intermedias - 2 instancias para pruebas de concurrencia
  desired_capacity = 2
  min_capacity     = 2
  max_capacity     = 4
  
  # Configuración de escalado
  # Cooldowns más cortos para responder más rápido en QA
  scale_up_cooldown    = 180
  scale_down_cooldown  = 180
  
  # Umbrales de escalado (porcentage de CPU)
  # Más sensibles que producción para detectar problemas temprano
  scale_up_threshold   = 65
  scale_down_threshold = 35
  
  # Configuración de health check
  health_check_grace_period_seconds = 90
  
  # Timeout de tarea
  task_timeout_minutes = 15
}

# ============================================
# Configuración de Base de Datos RDS PostgreSQL
# ============================================
rds_postgresql = {
  # Instancia mediana para QA - db.t3.small para pruebas de carga
  instance_class = "db.t3.small"
  
  # Almacenamiento moderado - 50GB para datos de pruebas
  allocated_storage_gb = 50
  
  # Storage type gp3 para mejor rendimiento
  storage_type = "gp3"
  
  # Multi-AZ activado para simular entorno de producción
  multi_az = true
  
  # Backup retention moderado - 7 días para QA
  backup_retention_days = 7
  
  # Ventana de mantenimiento en horario no crítico
  maintenance_window = "sun:02:00-sun:03:00"
  
  # Backup window en horario no crítico
  backup_window = "01:00-02:00"
  
  # Eliminación protegida
  deletion_protection = true
  
  # Performance Insights activado para análisis
  enable_performance_insights = true
  
  # Logging completo para debugging
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade", "audit"]
  
  # Parámetros de conexión
  max_connections = 200
  
  # Cifrado en reposo
  storage_encrypted = true
}

# ============================================
# Configuración del Load Balancer (ALB)
# ============================================
load_balancer = {
  # Protección contra eliminación activada
  enable_deletion_protection = true
  
  # Timeout de inactividad estándar
  idle_timeout_seconds = 60
  
  # SSL activado para pruebas de certificados
  enable_ssl = true
  
  # Access logs habilitados para análisis
  enable_access_logs = true
  
  # Cross-zone balancing activado
  enable_cross_zone_load_balancing = true
}

# ============================================
# Configuración de Monitoring y Alarmas
# ============================================
monitoring = {
  # Alarmas con umbrales intermedios
  # Simulan producción pero con margen para pruebas
  
  # Umbral de CPU - 75%
  cpu_alarm_threshold = 75
  
  # Umbral de memoria - 80%
  memory_alarm_threshold = 80
  
  # Umbral de latencia - 300ms
  latency_alarm_threshold_ms = 300
  
  # Umbral de errores - 3%
  error_rate_threshold = 3
  
  # ALB 5xx errors threshold
  alb_5xx_threshold = 5
  
  # Target response time threshold
  target_response_time_threshold = 0.5
  
  # Período de evaluación estándar
  evaluation_period_seconds = 180
  
  # Período de datos para alarma
  datapoints_to_alarm = 2
  
  # Slack channel para notificaciones de QA
  notification_topic = "qa-alerts"
  
  # Dashboard detallado activado
  create_detailed_dashboard = true
}

# ============================================
# Configuración de Alta Disponibilidad
# ============================================
ha_config = {
  # Alta disponibilidad activada en QA
  multi_az = true
  
  # RTO objetivo en horas
  rto_hours = 2
  
  # RPO objetivo en horas
  rpo_hours = 1
  
  # Replicación activada
  enable_replication = true
}

// === ARCHIVO: environments/prod/terraform.tfvars ===
# Configuración de variables para el ambiente de PRODUCCIÓN
# Objetivo: Alta disponibilidad, rendimiento óptimo y recuperación ante desastres
# Cumplimiento de SLA: 99.9% uptime, 5000 req/s, latencia < 200ms

# ============================================
# Configuración de Red y Entorno
# ============================================
environment             = "prod"
aws_region              = "us-east-1"
project_name            = "banking-platform"

# Tags obligatorios para identificación y costos
tags = {
  Environment     = "prod"
  Project         = "banking-platform"
  ManagedBy       = "terraform"
  CostCenter      = "it-production"
  ComplianceLevel = "pci-dss"
}

# ============================================
# Configuración del Cluster Tomcat (ECS/Fargate)
# ============================================
tomcat_cluster = {
  # Instancias grandes para producción - t3.large para alto rendimiento
  instance_type = "t3.large"
  
  # Réplicas para alta disponibilidad - mínimo 3 instancias
  # Distribuidas en múltiples AZs para tolerancia a fallos
  desired_capacity = 4
  min_capacity     = 3
  max_capacity     = 10
  
  # Configuración de escalado
  # Respuesta rápida para manejar picos de tráfico
  scale_up_cooldown    = 60
  scale_down_cooldown  = 300
  
  # Umbrales de escalado optimizados para 5000 req/s
  # Escalado proactivo basado en experiencia operativa
  scale_up_threshold   = 60
  scale_down_threshold = 25
  
  # Configuración de health check
  # Período de gracia más largo para estabilidad
  health_check_grace_period_seconds = 120
  
  # Timeout de tarea
  task_timeout_minutes = 30
}

# ============================================
# Configuración de Base de Datos RDS PostgreSQL
# ============================================
rds_postgresql = {
  # Instancia grande para producción - db.r6g.large (ARM) o db.r5.large (x86)
  instance_class = "db.r6g.large"
  
  # Almacenamiento generoso - 200GB para datos de producción
  allocated_storage_gb = 200
  
  # Storage type gp3 para IOPS garantizados
  storage_type = "gp3"
  
  # Multi-AZ obligatorio para producción
  multi_az = true
  
  # Backup retention largo - 30 días para cumplimiento PCI-DSS
  backup_retention_days = 30
  
  # Ventana de mantenimiento en horario de menor tráfico
  maintenance_window = "sun:01:00-sun:03:00"
  
  # Backup window en horario no crítico
  backup_window = "00:00-01:00"
  
  # Eliminación protegida - crítico para producción
  deletion_protection = true
  
  # Performance Insights activado para optimización continua
  enable_performance_insights = true
  
  # Logging completo para auditoría PCI-DSS
  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade", "audit"]
  
  # Parámetros de conexión optimizados
  max_connections = 500
  
  # Cifrado en reposo obligatorio
  storage_encrypted = true
  
  # Habilitar aurora para mejor rendimiento
  # Nota: Si se usa Aurora, cambiar a aurora-postgresql
  engine = "postgres"
}

# ============================================
# Configuración del Load Balancer (ALB)
# ============================================
load_balancer = {
  # Protección contra eliminación obligatoria en producción
  enable_deletion_protection = true
  
  # Timeout de inactividad estándar para sesiones largas
  idle_timeout_seconds = 60
  
  # SSL obligatorio con certificado de producción
  enable_ssl = true
  
  # Access logs obligatoria para auditoría y análisis
  enable_access_logs = true
  
  # Cross-zone balancing obligatorio para HA
  enable_cross_zone_load_balancing = true
  
  # WAF habilitado para protección
  enable_waf = true
}

# ============================================
# Configuración de Monitoring y Alarmas
# ============================================
monitoring = {
  # Alarmas estrictas para cumplir SLA de 99.9%
  # Detección temprana de problemas
  
  # Umbral de CPU - 70% para respuesta proactiva
  cpu_alarm_threshold = 70
  
  # Umbral de memoria - 75%
  memory_alarm_threshold = 75
  
  # Umbral de latencia estricto - 200ms (SLA)
  latency_alarm_threshold_ms = 200
  
  # Umbral de errores muy bajo - 1%
  error_rate_threshold = 1
  
  # ALB 5xx errors threshold - muy estricto
  alb_5xx_threshold = 2
  
  # Target response time threshold
  target_response_time_threshold = 0.3
  
  # Período de evaluación corto para respuesta rápida
  evaluation_period_seconds = 60
  
  # Múltiples datapoints para evitar falsos positivos
  datapoints_to_alarm = 3
  
  # Slack channel para alertas de producción
  notification_topic = "prod-alerts-critical"
  
  # Dashboard detallado obligatorio
  create_detailed_dashboard = true
  
  # Métricas personalizadas habilitadas
  enable_custom_metrics = true
}

# ============================================
# Configuración de Alta Disponibilidad y Recuperación
# ============================================
ha_config = {
  # Alta disponibilidad completa en producción
  multi_az = true
  
  # RTO objetivo: 15 minutos (recuperación rápida)
  rto_hours = 0.25
  
  # RPO objetivo: 5 minutos (pérdida mínima de datos)
  rpo_hours = 0.083
  
  # Replicación activa entre regiones (disaster recovery)
  enable_replication = true
  
  # Región secundaria para DR
  dr_region = "us-west-2"
  
  # Failover automático habilitado
  enable_auto_failover = true
}

# ============================================
# Configuración de Seguridad Cumplimiento PCI-DSS
# ============================================
security_config = {
  # Habilitar VPC Flow Logs para auditoría
  enable_vpc_flow_logs = true
  
  # Habilitar GuardDuty
  enable_guardduty = true
  
  # Habilitar Security Hub
  enable_security_hub = true
  
  # Habilitar Config
  enable_config = true
  
  # Política de retención de logs
  logs_retention_days = 90
  
  # Habilitar encryption en tránsito
  enforce_ssl = true
}

```
