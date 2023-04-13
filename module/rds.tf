resource "aws_db_instance" "mysql" {
  identifier             = "${var.env_name}-db"
  allocated_storage      = var.storage
  engine                 = "mysql"
  engine_version         = "8.0.31"
  instance_class         = var.instance_class
  username               = var.db_username
  password               = aws_secretsmanager_secret_version.mysql_password_secret_version.secret_string
  skip_final_snapshot    = var.mysql_snapshot
  vpc_security_group_ids = [aws_security_group.allow_3306_from_ec2.id]
  db_subnet_group_name   = aws_db_subnet_group.private_db_group.name
  multi_az               = var.multi_az

}

resource "aws_db_subnet_group" "private_db_group" {
  name       = "${var.env_name}-private-db-group"
  subnet_ids = aws_subnet.private.*.id

  tags = merge(var.tags,
    {
      "Name" = "${var.env_name}-mysql"
    }
  )
}
