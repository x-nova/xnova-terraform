output "repository_uri" {
  value = aws_ecr_repository.this.repository_url
}

output "repository_name" {
  value = aws_ecr_repository.this.name
}