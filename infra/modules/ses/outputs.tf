output "domain_identity_arn" {
  value = aws_ses_domain_identity.main.arn
}

output "email_identity_arn" {
  value = aws_ses_email_identity.admin.arn
}