variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Project name prefix for resources"
  type        = string
  default     = "cloud-file-processor"
}

variable "environment" {
  description = "Environment name (dev/stage/prod)"
  type        = string
  default     = "dev"
}
