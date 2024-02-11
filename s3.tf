resource "aws_s3_bucket" "brp_s3" {
  bucket = "brp-closures-frontend" 
}

resource "aws_s3_bucket_website_configuration" "brp_s3" {
  bucket = aws_s3_bucket.brp_s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }

}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.brp_s3.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = ["s3:GetObject"]
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.brp_s3.arn}/*"
        Principal = "*"
      },
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "brp_s3" {
  bucket = aws_s3_bucket.brp_s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

