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