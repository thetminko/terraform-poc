data "template_file" "tf-ecs-task-template" {
  template = file("templates/app.json.tpl")
  vars = {
    REPOSITORY_URL = replace(aws_ecr_repository.tf-poc-ecr.repository_url, "https://", "")
  }
}

resource "aws_ecs_task_definition" "tf-ecs-task-definition" {
  family                = "tf-ecs-poc-app"
  container_definitions = data.template_file.tf-ecs-task-template.rendered
}


resource "aws_ecs_service" "tf-task-service" {
  name            = "tf-ecs-poc-app"
  cluster         = aws_ecs_cluster.tf-ecs-cluster.id
  task_definition = aws_ecs_task_definition.tf-ecs-task-definition.arn
  desired_count   = 1
  iam_role        = aws_iam_role.tf-ecs-role.arn
  depends_on      = [aws_iam_policy_attachment.tf-ecs-rp-attach, aws_alb_listener.tf-ecs-alb-listener]


  load_balancer {
    target_group_arn = aws_alb_target_group.tf-ecs-target-group.arn

    container_name = "tf-ecs-poc-app"
    container_port = 3000
  }
  lifecycle {
    ignore_changes = [task_definition]
  }
}
