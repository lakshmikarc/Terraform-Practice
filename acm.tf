data "aws_acm_certificate" "example" {
  domain   = "tf.example.com"
  statuses = ["ISSUED"]
}

data "aws_acm_certificate" "example" {
  domain      = "tf.example.com"
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}