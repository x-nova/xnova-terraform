resource "aws_ecr_repository" "ecs" {
  name                 = "${var.environment}-${var.project}/${var.project_component}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    createdby   = var.createdby
    project     = var.project
    Name        = var.project_component
    environment = var.environment
  }
}

data "external" "tags_of_most_recently_pushed_image" {
  program = [
    "aws", "ecr", "describe-images",
    "--repository-name", "${aws_ecr_repository.ecs.name}",
    "--query", "{\"tags\": to_string(sort_by(imageDetails, &imagePushedAt)[-1].imageTags)}",
    "--region", "${var.region}"
  ]
}

output "repository_uri" {
  value = aws_ecr_repository.ecs.repository_url
}
