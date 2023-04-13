
# resource "aws_iam_role_policy" "iam_role_policy" {
#   name   = "${var.env_name}"
#   policy = data.aws_iam_policy_document.execution_policy.json
#   role   = aws_iam_role.execution_role.id
# }
