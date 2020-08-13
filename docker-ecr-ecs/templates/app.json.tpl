[
  {
    "essential": true,
    "memory": 256,
    "name": "tf-ecs-poc-app",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:1",
    "workingDirectory": "/app", 
    "command": ["npm", "start"],
    "portMappings": [
        {
            "containerPort": 3000,
            "hostPort": 80
        }
    ]
  }
]

