
data "terraform_remote_state" "global" {
  backend = "s3"

  config = {
    bucket = "terraform-remote-state-kofo"
    key    = "${var.env_name}/terraform.tfstate"
    region = var.region
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.aws_ami]
  }
}

data "aws_iam_policy_document" "assume_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

