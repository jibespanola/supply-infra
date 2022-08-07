terraform {
  backend "s3" {
    bucket = "supplycart-terraform-dev"
    key    = "terraform/state/key"
    region = "ap-southeast-1"
  }
}
