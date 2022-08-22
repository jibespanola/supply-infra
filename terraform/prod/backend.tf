terraform {
  backend "s3" {
    bucket = "supplycart-terraform-prod"
    key    = "terraform/state/key"
    region = "ap-southeast-1"
  }
}
