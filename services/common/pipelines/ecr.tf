resource "aws_ecr_repository" "ecs" {
  name                 = "${var.project}-${var.component}-${var.environment}"
  image_tag_mutability = "IMMUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Project     = var.project
    Name        = var.component
    Environment = var.environment
  }
}

# data "external" "tags_of_most_recently_pushed_image" {
#   program = [
#     "aws", "ecr", "describe-images",
#     "--repository-name", "${aws_ecr_repository.ecs.name}",
#     "--query", "{\"tags\": to_string(sort_by(imageDetails, &imagePushedAt)[-1].imageTags)}",
#     "--region", "${var.region}"
#   ]
# }

output "repository_uri" {
  value = aws_ecr_repository.ecs.repository_url
}
