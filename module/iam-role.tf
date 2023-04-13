
resource "aws_iam_role" "ec2_role" {
  name               = "${var.env_name}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.assume_policy.json
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}


