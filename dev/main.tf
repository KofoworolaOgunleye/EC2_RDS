module "ec2_rds" {
  source = "../module"

  region               = local.region
  env_name             = local.env_name
  cidr_block           = local.cidr_block
  aws_ami              = local.aws_ami
  instance_type        = local.instance_type
  availability_zones   = local.availability_zones
  public_subnets_cidr  = local.public_subnets_cidr
  private_subnets_cidr = local.private_subnets_cidr
  multi_az             = local.multi_az
  db_username          = local.db_username
  instance_class       = local.instance_class
  storage              = local.storage
  mysql_snapshot       = local.mysql_snapshot
  tags                 = local.tags
}
