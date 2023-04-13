variable "cidr_block" {
  type = string
}

variable "env_name" {
  type = string
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "Public Subnet CIDR values"
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "Private Subnet CIDR values"
}

variable "availability_zones" {
  type = list(any)
}

variable "region" {
  type = string
}

variable "aws_ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "multi_az" {
  type = bool
}

variable "db_username" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "storage" {
  type = string
}

variable "mysql_snapshot" {
  type = bool
}

variable "tags" {
  type = any

}