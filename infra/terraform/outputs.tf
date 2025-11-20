output "s3_bucket_name" {
  description = "Name of S3 bucket for file processor"
  value       = aws_s3_bucket.files.bucket
}
