## Terraform Structure

The terraform structure in this project uses a combination of community-developed AWS modules and our own simplified custom modules. With this logical structure, resource configurations are packaged and can be re-used across different environments.

Custom modules are stored in the `terraform/modules` directory in this repository. You can modify certain configurations if you expect this to be shareable across environments.

For a comprehensive list of community-developed AWS modules: [Terraform AWS modules | Terraform Registry](https://registry.terraform.io/namespaces/terraform-aws-modules)

Below is a summary of the modules being used in the project.

- VPC from [terraform-aws-modules/vpc/aws](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)
- S3 from [terraform-aws-modules/s3-bucket/aws](https://registry.terraform.io/modules/terraform-aws-modules/s3-bucket/aws/latest)
- ECS under `terraform/modules/ecs`
  - Container templates are found under `terraform/templates`
- Security Groups under `terraform/modules/securitygroups`
- RDS under `terraform/modules/rds`
- ALB under `terraform/modules/alb`
- IAM policies and roles under `terraform/modules/iam`

## Prerequisites

### Installing Terraform

[Install Terraform | Terraform - HashiCorp Learn](https://learn.hashicorp.com/tutorials/terraform/install-cli)

### Loading AWS credentials

Make sure to load your AWS credentials through a named profile or by exporting the necessary environment variables.

```bash
export AWS_ACCESS_KEY_ID=your-access-key-id
export AWS_SECRET_ACCESS_KEY=your-secret-access-key
export AWS_DEFAULT_REGION=your-targeted-region
```

If you prefer storing and using named profiles for AWS CLI, follow this guide: [Named profiles for the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)

After creating your named profile, simply run:

```bash
export AWS_PROFILE=your-profile-name
```

## Loading Secrets

To retrieve secrets from Secrets Manager and load them into your Terraform configurations:

1. Manually create the secret as a JSON store either through the AWS console or CLI
2. Modify the following in the `secretsmanager.tf` file

```yaml
data "aws_secretsmanager_secret_version" "creds" {
	secret_id = "secret-name" # change this to your secret's ID
}



locals {
	"secret_json" = jsondecode(
		data.aws_secretsmanager_secret_version.creds.secret_string
	)
}
```

Now to make use of the secret, just call the specific key from your decoded locals. In this case, we stored our DB password with a key name of `db_password` in a local data source named `secret_json`

```yaml
db_password = local.secret_json.db_password
```

## I want my own environment

1. Duplicate the `dev` and rename the folder accordingly
2. Make sure your AWS credentials are loaded in the current shell (check prerequisites section)
3. Manually create an S3 bucket that will store the state of your infrastructure
   - Make sure to enable `Bucket Versioning` if you care about state recovery
4. In the `backend.tf` file, change the bucket name and region accordingly.

```yaml
terraform {
	backend "s3" {
		bucket = "bucket-name-from-step2" # Change this!
		key = "terraform/state/key"
		region = "region-for-your-infra" # Change this!
	}
}
```

4. While inside the directory of your environment, run `terraform init`
5. Reconfigure the variable inputs stored in `dev.tfvars`. You may also change the file name to more accurately reflect your environment
6. Run `terraform fmt` to lint your terraform code
7. Run `terraform validate` to validate your terraform configurations
8. Run `terraform plan -var-file="dev.tfvars"` and see if there are any issues. If there are, resolve accordingly.
9. If you're ready, run `terraform apply -var-file="dev.tfvars"`
10. If you need to clean up, run `terraform destroy`
