# scale up
resource "aws_autoscaling_policy" "tf-autoscaling-up-policy" {
  name                   = "tf-autoscaling-policy"
  scaling_adjustment     = "1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.tf-autoscaling-group.name
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "tf-cpu-alarm-up" {
  alarm_name          = "tf-cpu-alarm-up"
  alarm_description   = "tf-cpu-alarm-up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.tf-autoscaling-group.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.tf-autoscaling-up-policy.arn]
}


# scale down alarm
resource "aws_autoscaling_policy" "tf-autoscaling-down-policy" {
  name                   = "tf-autoscaling-down-policy"
  autoscaling_group_name = aws_autoscaling_group.tf-autoscaling-group.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "tf-cpu-alarm-down" {
  alarm_name          = "tf-cpu-alarm-down"
  alarm_description   = "tf-cpu-alarm-down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.tf-autoscaling-group.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.tf-autoscaling-down-policy.arn]
}
