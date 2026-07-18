terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

resource "aws_acm_certificate" "main" {
  domain_name               = var.domain_name
  subject_alternative_names = ["*.${var.domain_name}"]
  validation_method         = "DNS"

  tags = {
    Name        = "${var.name_prefix}-acm-certificate"
    environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "cloudflare_record" "dns_validation" {
  zone_id = var.cloudflare_zone_id
  name    = tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_type
  content = trimsuffix(tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_value, ".")
  ttl     = 60
  proxied = false
}

resource "aws_acm_certificate_validation" "main" {
  certificate_arn = aws_acm_certificate.main.arn
  validation_record_fqdns = [
    tolist(aws_acm_certificate.main.domain_validation_options)[0].resource_record_name
  ]

  depends_on = [cloudflare_record.dns_validation]
}