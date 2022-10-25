PROJECT := "supplyflow"
REGION := "ap-southeast-1"
BUCKET_NAME := "tf-state"
DYNAMODB_TABLE_NAME := "tf-lock"
SHA := `git rev-parse --short HEAD`

profile env:
	aws configure --profile {{PROJECT}}-{{env}}

s3 env:
    aws s3api create-bucket \
        --acl private \
        --bucket {{PROJECT}}-{{BUCKET_NAME}}-{{env}} \
        --region {{REGION}} \
        --create-bucket-configuration LocationConstraint={{REGION}} \
        --profile {{PROJECT}}-{{env}}

    aws s3api put-bucket-versioning \
        --bucket {{PROJECT}}-{{BUCKET_NAME}}-{{env}} \
        --versioning-configuration Status=Enabled \
        --profile {{PROJECT}}-{{env}}

    aws s3api put-public-access-block \
        --bucket {{PROJECT}}-{{BUCKET_NAME}}-{{env}} \
        --public-access-block-configuration \
        "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=true,RestrictPublicBuckets=true" \
        --profile {{PROJECT}}-{{env}}

dynamodb env:
	aws dynamodb create-table \
		--table-name {{PROJECT}}-{{DYNAMODB_TABLE_NAME}}-{{env}} \
		--region {{REGION}} \
		--attribute-definitions AttributeName=LockID,AttributeType=S \
		--key-schema AttributeName=LockID,KeyType=HASH \
		--provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 \
		--profile {{env}}
        
generate env:
    just profile {{env}}
    just s3 {{env}}
    just dynamodb {{env}}

@format-mods:
	for dir in terraform/modules/*/; do \
		cd $dir; \
		echo "currently at $dir"; \
		terraform fmt; \
		cd -; \
	done

format env:
    just format-mods
    cd terraform/{{env}}/; terraform fmt

plan env:
    cd terraform/{{env}}; terraform init; terraform validate; \
    terraform plan \
        -var-file="{{env}}.tfvars" \
        -input=false \
        -out=tfplan

apply env:
	cd terraform/{{env}}; terraform apply \
		-input=false \
		tfplan

destroy env:
    cd terraform/{{env}}; terraform destroy \
        -var-file="{{env}}.tfvars"

ecs env: 
	python3 -m venv ./deploy_ecs/venv/
	source ./deploy_ecs/venv/bin/activate; pip install boto3 click; \
	python ./deploy_ecs/update_ecs.py \
		--cluster=supplycart-{{env}}-cluster --service=supplycart-{env}-django-service && \
	python ./deploy_ecs/update_ecs.py \
		--cluster=supplycart-{{env}}-cluster --service=supplycart-{{env}}-react-service
    