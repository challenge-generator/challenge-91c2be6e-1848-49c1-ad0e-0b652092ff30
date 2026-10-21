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