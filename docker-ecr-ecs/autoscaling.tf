resource "aws_launch_configuration" "tf-ecs-lc" {
  name_prefix = "tf-ecs-lc"
  # image_id             = data.aws_ami.ecs_ami.id
  image_id             = "ami-0167e83338bdf98c2"
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.tf-keypair.key_name
  iam_instance_profile = aws_iam_instance_profile.tf-ecs-ec2-iip.id
  security_groups      = [aws_security_group.tf-ecs-sg.id]
  user_data            = "#!/bin/bash\necho 'ECS_CLUSTER=tf-ecs-cluster' > /etc/ecs/ecs.config\nstart ecs"
  # the ECS_CLUSTER name must be the same as the one specified in ecs cluster

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "tf-ecs-asg" {
  name_prefix          = "tf-ecs-ec2"
  vpc_zone_identifier  = [aws_subnet.tf-ecs-public-subnet1.id, aws_subnet.tf-ecs-public-subnet2.id, aws_subnet.tf-ecs-public-subnet3.id]
  launch_configuration = aws_launch_configuration.tf-ecs-lc.name
  min_size             = 1
  max_size             = 2
  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "tf-ecs-instances"
    propagate_at_launch = true
  }
}
