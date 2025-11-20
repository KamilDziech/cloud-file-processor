locals {
  s3_bucket_name = "${var.project_name}-${var.environment}"
}

resource "aws_s3_bucket" "files" {
  bucket = local.s3_bucket_name

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "files" {
  bucket = aws_s3_bucket.files.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
