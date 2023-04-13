locals {
  region = "eu-west-1"

  env_name = "dev"

  cidr_block = "10.0.0.0/16"

  aws_ami = "al2023-ami-2023.0.20230329.0-kernel-6.1-x86_64"

  instance_type = "t2.nano"

  availability_zones = ["eu-west-1a", "eu-west-1b"]

  public_subnets_cidr = ["10.0.0.0/18", "10.0.64.0/18"]

  private_subnets_cidr = ["10.0.128.0/18", "10.0.192.0/18"]

  multi_az = "false"

  db_username = "kofo"

  instance_class = "db.t2.micro"

  storage = "10"

  mysql_snapshot = "true"


  tags = {
    project    = "EC2_RDS"
    created_by = "Terraform"
  }
}
