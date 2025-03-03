resource "aws_ecr_repository" "ec2-go" {
  name                 = var.repository_name
  image_tag_mutability = "MUTABLE"

  lifecycle {
    prevent_destroy = false
  }
}