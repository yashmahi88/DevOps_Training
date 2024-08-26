resource "aws_secretsmanager_secret" "yashm_db_secret" {
  name = "yashm_db_secret3"
}

resource "aws_secretsmanager_secret_version" "yashm_db_secret_version" {
  secret_id     = aws_secretsmanager_secret.yashm_db_secret.id
  secret_string = jsonencode({
    password = var.db_password
  })
}