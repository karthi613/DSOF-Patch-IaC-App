resource "aws_kms_key" "a" {
  description             = "key 1"
  deletion_window_in_days = 10
  enable_key_rotation = true
}

output "kms_key" {
  value = aws_kms_key.a.key_id
}