
#Launch template
resource "aws_launch_template" "instance" {
  name_prefix            = "instance"
  image_id               = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_80_from_lb.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.profile.arn
  }

  tags = merge(var.tags,
    {
      "Name" = "${var.env_name}-instance-profile"
    }
  )



  #   user_data = filebase64("${path.module}/example.sh")
}

#Autoscaling group
resource "aws_autoscaling_group" "instance_asg" {
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = aws_subnet.private.*.id

  launch_template {
    id      = aws_launch_template.instance.id
    version = "$Latest"
  }
}

#Instance profile
resource "aws_iam_instance_profile" "profile" {
  name = "${var.env_name}-ec2-profile"
  role = aws_iam_role.ec2_role.name
}


