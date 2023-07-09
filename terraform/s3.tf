resource "aws_s3_bucket" "gpi_customerout_bucket_access_logs" {
  bucket = "${var.environment}-customerout-logs"
  acl  = "private"
}

