# create the S3 bucket for website hosting
resource "aws_s3_bucket" "site" {
  bucket = var.bucket_name
  acl    = "public-read"   # we make objects readable; the bucket policy (below) also allows GET
  force_destroy = true     # useful for dev: lets terraform destroy non-empty bucket

  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  tags = {
    Name = "static-site-${var.bucket_name}"
    Env  = "demo"
  }
}

# Ensure we do NOT block public access at the bucket level for this demo site
resource "aws_s3_bucket_public_access_block" "allow_public" {
  bucket                  = aws_s3_bucket.site.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# policy: allow anyone to read objects (s3:GetObject)
data "aws_iam_policy_document" "public_read" {
  statement {
    sid = "PublicReadGetObject"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "policy" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.public_read.json
}

# Upload the site files (index + 404)
resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.site.id
  key          = "index.html"
  source       = "${path.module}/../site/index.html"
  content_type = "text/html"
  acl          = "public-read"
}

resource "aws_s3_bucket_object" "404" {
  bucket       = aws_s3_bucket.site.id
  key          = "404.html"
  source       = "${path.module}/../site/404.html"
  content_type = "text/html"
  acl          = "public-read"
}

