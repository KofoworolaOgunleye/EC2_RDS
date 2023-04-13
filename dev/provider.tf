terraform {
  required_version = "~> 1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {

    bucket = "terraform-remote-state-kofo"
    key    = "dev/terraform.tfstate"
    region = "eu-west-1"
  }

}

provider "aws" {
  region = local.region
}