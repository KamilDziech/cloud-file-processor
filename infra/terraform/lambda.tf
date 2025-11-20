data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../../lambda/handler.py"
  output_path = "${path.module}/../../lambda/handler.zip"
}

resource "aws_lambda_function" "file_processor" {
  function_name = "${var.project_name}-${var.environment}-lambda"

  role    = aws_iam_role.lambda_execution_role.arn
  handler = "handler.lambda_handler"
  runtime = "python3.11"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  timeout = 30

  environment {
    variables = {
      BUCKET_NAME      = aws_s3_bucket.files.bucket
      RESULTS_PREFIX   = "results/"
      INPUT_PREFIX     = "input/"
      QUEUE_URL        = aws_sqs_queue.jobs.id
    }
  }

  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn = aws_sqs_queue.jobs.arn
  function_name    = aws_lambda_function.file_processor.arn

  batch_size = 1   # na razie 1 wiadomosc na wywołanie
  enabled    = true
}
