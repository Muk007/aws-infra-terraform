module "management-vpc" {
  source = "./management-vpc"
}

module "vpc-configs" {
  source = "./vpc-configs"
  vpc_id = "${module.management-vpc.vpc_id}" 
}
