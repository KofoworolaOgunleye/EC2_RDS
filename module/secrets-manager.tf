#generates random password
resource "random_password" "mysql_password" {
  length  = 16
  special = false
  upper   = true
}

#stores password in secretmanager
resource "aws_secretsmanager_secret" "mysql_password_secrets" {
  name                    = "${var.env_name}-mysql"
  recovery_window_in_days = 0
}

#secret versioning
resource "aws_secretsmanager_secret_version" "mysql_password_secret_version" {
  secret_id     = aws_secretsmanager_secret.mysql_password_secrets.id
  secret_string = random_password.mysql_password.result
}