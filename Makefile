REGION = ap-southeast-1
AWS_ACC = 011095803615
DIR := ${CURDIR}
SHA := $$(git rev-parse --short HEAD)

.PHONY: check-creds
check-creds:
	@if [ -z $(AWS_ACCESS_KEY_ID) ]; then \
		echo "$(BOLD)$(RED)AWS_ACCESS_KEY_ID was not set. \nThis will cause your Terraform and ECS authentication fail.$(RESET)"; \
		ERROR=1; \
	 fi
	@if [ -z $(AWS_DEFAULT_REGION) ]; then \
		echo "$(BOLD)$(RED)AWS_DEFAULT_REGION was not set. \nThis will cause your Terraform and ECS authentication fail.$(RESET)"; \
		ERROR=1; \
	 fi
	@if [ -z $(AWS_SECRET_ACCESS_KEY) ]; then \
		echo "$(BOLD)$(RED)AWS_SECRET_ACCESS_KEY was not set. \nThis will cause your Terraform and ECS authentication fail.$(RESET)"; \
		ERROR=1; \
	 fi

.PHONY: format-modules
format-modules:
	@for dir in terraform/modules/*/; do \
    	cd $$dir; \
		terraform fmt; \
		cd -; \
	done

.PHONY: tf-plandev
tf-plandev: check-creds format-modules
	cd terraform/dev; terraform init; terraform fmt; terraform validate && \
	terraform plan \
		-var-file="dev.tfvars" \
        -input=false

.PHONY: tf-applydev
tf-applydev: tf-plandev 
	cd terraform/dev; terraform apply \
		-var-file="dev.tfvars" \
        -input=false \
		tfplan

.PHONY: tf-destroydev 
tf-destroydev:
	cd terraform/dev; terraform destroy \
		-var-file="dev.tfvars" \


.PHONY: deploy-ecsdev 
deploy-ecsdev: tf-applydev
	python3 -m venv ./deploy_ecs/venv/
	source ./deploy_ecs/venv/bin/activate; pip install boto3 click; \
	python ./deploy_ecs/update_ecs.py \
		--cluster=supplycart-dev-cluster --service=supplycart-dev-django-service && \
	python ./deploy_ecs/update_ecs.py \
		--cluster=supplycart-dev-cluster --service=supplycart-dev-react-service


