resource "aws_cloudtrail" "insecure-logging" {
  name           = "cloudtrail-logging"
  s3_bucket_name = "my-cloudtrail-bucket"
  enable_logging = true
  enable_log_file_validation  = true
  is_multi_region_trail = true
  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.insecure-logging.arn
}

resource "aws_cloudwatch_log_group" "insecure-logging" {
  name = "aws_cloudtrail_log"
  retention_in_days = 1
  kms_key_id = var.kms_key_id
  tags = {
    Name = "aws_cloudtrail_log"
  }
}

variable "kms_key_id" {
  type = string
}