variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Global unique bucket name (e.g. my-unique-site-12345)"
  type        = string
}

