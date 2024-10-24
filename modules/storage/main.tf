resource "aws_s3_bucket" "insecure-bucket" {
  bucket = "insecure-bucket"
}

resource "aws_s3_bucket_versioning" "version" {
  bucket = aws_s3_bucket.insecure-bucket
  versioning_configuration {
    status = "Enabled"
    mfa_delete = "Enabled"
  }
}

resource "aws_s3_bucket_logging " "name" {
   bucket = aws_s3_bucket.insecure-bucket
    target_bucket = aws_s3_bucket.insecure-bucket
    target_prefix = "log/"

    depends_on = [aws_s3_bucket.insecure-bucket]
}

# resource "aws_s3_bucket_public_access_block" "insecure-bucket" {
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 20
  encrypted         = true
 
  tags = {
    Name = "insecure"
  }
}
