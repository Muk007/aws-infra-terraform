module "management-vpc" {
#  for_each  = toset(["management", "production", "development"])
#  namespace = "${each.key}"
  source = "./management-vpc"
  cidr   = "10.0.0.0/16"
  subnet_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  avail_zone = ["us-east-1a", "us-east-1b"]
  private_avail_zone = ["us-east-1c", "us-east-1d"]
  global_ip = "0.0.0.0/0"
  namespace = "production"
}

module "vpc-configs" {
#   for_each  = toset(["management", "production", "development"])
#   namespace = "${each.key}"
   source = "./vpc-configs"
   vpc_id = "${module.management-vpc.vpc_id}" 
   aws_region = var.aws_region
   namespace = "production"
}
