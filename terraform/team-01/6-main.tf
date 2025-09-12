terraform {
  backend "s3" {
    bucket         = "bm-devops-state-bucket2"       # change here
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
module "vpc" {
  source = "../infrastructure-modules/vpc"

  environment      = "dev"
  project         = "sprints"
  private-subnets = ["10.0.128.0/20", "10.0.144.0/20"]
  public-subnets  = ["10.0.0.0/20", "10.0.16.0/20"]
  azs             = ["us-east-1a", "us-east-1b"]
}

module "eks" {
  source          = "../infrastructure-modules/eks"

  cluster_name    = "GP-cluster"
  cluster_version = "1.33"
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.public_subnet_ids
  node_groups    = var.node_groups
  depends_on     = [module.vpc]
}
