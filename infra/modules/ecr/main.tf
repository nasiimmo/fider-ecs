resource "aws_ecr_repository" "main" {
  name                 = "fider-ecs"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name        = "${var.name_prefix}-ecr"
    environment = var.environment
  }
}