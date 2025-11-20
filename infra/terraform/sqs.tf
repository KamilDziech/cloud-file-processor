locals {
  sqs_queue_name = "${var.project_name}-${var.environment}-queue"
}

resource "aws_sqs_queue" "jobs" {
  name = local.sqs_queue_name

  visibility_timeout_seconds = 30
  message_retention_seconds  = 86400   # 1 dzień
  delay_seconds              = 0
  receive_wait_time_seconds  = 0

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
