[
  {
    "name": "${app_name}-${env}-fastapi",
    "image": "${image_target}",
    "essential": true,
    "cpu": 10,
    "memory": 1000,
    "links": [],
    "portMappings": [
      {
        "containerPort": 8000,
        "hostPort": 8000,
        "protocol": "tcp"
      }
    ],
    "command": ["uvicorn", "app.main:app", "--reload", "--workers", "1", "--host", "0.0.0.0", "--port", "8000"],
    "environment": [
      {
        "name": "DATABASE",
        "value": "${database}"
      },
      {
        "name": "DATABASE_URL",
        "value": "${database_url}"
      },
      {
        "name": "DB_ENGINE",
        "value": "${db_engine}"
      },
      {
        "name": "DB_USER",
        "value": "${db_user}"
      },
      {
        "name": "DB_PASSWORD",
        "value": "${db_password}"
      },
      {
        "name": "DB_NAME",
        "value": "${db_name}"
      },
      {
        "name": "DB_HOST",
        "value": "${db_host}"
      },
      {
        "name": "DB_PORT",
        "value": "${db_port}"
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/ecs/${app_name}-${env}-fastapi",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "fastapi-${app_name}-${env}-log-stream"
      }
    }
  }
]
