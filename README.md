# Purpose of this repository

Having a centralized repository for all IaC configurations will help with maintaing a single source of truth for any infrastructure provisioning and decouple our application code and their respective infra environments.

`GitOps = IaC + MRS + CI/CD`

## How will application repositories trigger this centralized Iac repository?

On a high-level:

1. [App Repo] Create a PR
2. [App Repo] Approve and merge to Trunk or Main
3. [App Repo] Run CI and Image Build
4. [IaC Repo] Go to `terraform/prod/prod.tfvars` and change the `image_tag` variable
5. [IaC Repo] Commit and Create a PR
6. [IaC Repo] Merge to Main

### Configuring Dev Env Locally

1. [IaC Repo] Go to `terraform/dev/dev.tfvars` and change the `image_tag` variable
2. Run `make tf-applydev`
3. Commit and push changes if final
