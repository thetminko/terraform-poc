resource "aws_launch_configuration" "tf-launch-configuration" {
  name_prefix     = "tf-launch-configuration-"
  image_id        = data.aws_ami.amzlinux2.id
  instance_type   = var.AWS_INSTANCE_TYPE
  key_name        = aws_key_pair.tf-poc.key_name
  security_groups = [aws_security_group.tf-poc-sg.id]
}

resource "aws_autoscaling_group" "tf-autoscaling-group" {
  name                      = "tf-autoscaling-group"
  vpc_zone_identifier       = [aws_subnet.tf-public-subnet-1.id]
  launch_configuration      = aws_launch_configuration.tf-launch-configuration.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "TF EC-2 Instance"
    propagate_at_launch = true
  }
}
