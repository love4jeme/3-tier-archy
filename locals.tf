locals {
  common_tags = {
    Project     = var.project_name
    Environment = terraform.workspace
    ManagedBy   = "Terraform"
    Owner       = "Blessing"
  }

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  data_subnet_cidrs    = ["10.0.5.0/24", "10.0.6.0/24"]
  azs                  = ["${var.aws_region}a", "${var.aws_region}b"]
}
