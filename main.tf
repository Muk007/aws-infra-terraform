module "vpc-dev" {
#  for_each  = toset(["management", "production", "development"])
#  namespace = "${each.key}"
  source = "./vpc"
  cidr   = "10.0.0.0/16"
  subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  avail_zone = ["us-east-1a", "us-east-1b"]
  private_avail_zone = ["us-east-1c", "us-east-1d"]
  global_ip = "0.0.0.0/0"
  namespace = "development"
}

module "vpc-dev-configs" {
#   for_each  = toset(["management", "production", "development"])
#   namespace = "${each.key}"
   source = "./vpc-configs"
   vpc_id = "${module.vpc-dev.vpc_id}" 
   aws_region = var.aws_region
   namespace = "development"
}
 
module "vpc-manage" {
#  for_each  = toset(["management", "production", "development"])
#  namespace = "${each.key}"
  source = "./vpc"
  cidr   = "10.0.0.0/16"
  subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  avail_zone = ["us-east-1a", "us-east-1b"]
  private_avail_zone = ["us-east-1c", "us-east-1d"]
  global_ip = "0.0.0.0/0"
  namespace = "management"
}

module "vpc-manage-configs" {
#   for_each  = toset(["management", "production", "development"])
#   namespace = "${each.key}"
   source = "./vpc-configs"
   vpc_id = "${module.vpc-manage.vpc_id}"
   aws_region = var.aws_region
   namespace = "management"
}

