[
  {
    "name": "${app_name}-${env}-react",
    "image": "${image_target}",
    "essential": true,
    "cpu": 10,
    "memory": 512,
    "links": [],
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000,
        "protocol": "tcp"
      }
    ],
    "environment": [],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${app_name}-${env}-react",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "react-${app_name}-${env}-log-stream"
      }
    }
  }
]
