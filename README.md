# Purpose of this repository

Having a centralized repository for all IaC configurations will help with maintaing a single source of truth for any infrastructure provisioning and decouple our application code and their respective infra environments.

`GitOps = IaC + MRS + CI/CD`

## How will application repositories trigger this centralized Iac repository?

On a high-level:

1. [App Repo] Create a PR
2. [App Repo] Approve and merge to Trunk or Main
3. [App Repo] Run CI and Image Build
4. [IaC Repo] Go to `terraform/<env>/<env>.tfvars` and change the `image_tag` variable
5. [IaC Repo] Commit and Create a PR
6. [IaC Repo] Merge to Main

## Generating necessary backend resources

In order for Terraform to work as expected, we need an S3 bucket to store remote state and a DynamoDB table to lock those states accordingly.

Locking helps make sure that only one team member runs terraform configuration -- it prevent conflicts, data loss, and state file corruption due to multiple runs on same state file

On your local environment, run `just generate <env-name>` to create the remote state S3 bucket and DynamoDB table.

### Configuring Dev Env Locally

1. [IaC Repo] Go to `terraform/dev/dev.tfvars` and change the `image_tag` variable
2. Run `just plan dev`
3. Ryn `just apply dev`
4. Commit and push changes if final
