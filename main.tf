module "vpc-dev" {
  source              = "./modules/vpc"
  cidr                = "10.0.0.0/16"
  subnet_cidr         = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
  avail_zone          = ["us-east-1a", "us-east-1b"]
  private_avail_zone  = ["us-east-1c", "us-east-1d"]
  global_ip           = "0.0.0.0/0"
  namespace           = "development"
}

module "vpc-dev-configs" {
  source     = "./modules/vpc-configs"
  vpc_id     = module.vpc-dev.vpc_id
  aws_region = var.aws_region
  namespace  = "development"
}

module "vpc-manage" {
  source              = "./modules/vpc"
  cidr                = "20.0.0.0/16"
  subnet_cidr         = ["20.0.1.0/24", "20.0.2.0/24"]
  private_subnet_cidr = ["20.0.3.0/24", "20.0.4.0/24"]
  avail_zone          = ["us-east-1a", "us-east-1b"]
  private_avail_zone  = ["us-east-1c", "us-east-1d"]
  global_ip           = "0.0.0.0/0"
  namespace           = "management"
}

module "vpc-manage-configs" {
  source     = "./modules/vpc-configs"
  vpc_id     = module.vpc-manage.vpc_id
  aws_region = var.aws_region
  namespace  = "management"
}

module "TGW" {
  source                          = "./modules/transit-gateway"
  vpc_id_manage                   = module.vpc-manage.vpc_id
  vpc_id_dev                      = module.vpc-dev.vpc_id
  auto_accept_shared_attachments  = "disable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"
  transit_gateway_cidr_blocks     = null
  subnet_dev                      = concat(module.vpc-dev.subnet_pri, module.vpc-dev.subnet_pub)
  subnet_manage                   = concat(module.vpc-manage.subnet_pub, module.vpc-manage.subnet_pri)
  #dev-rt                          = concat(module.vpc-dev.route_table_pub, module.vpc-dev.route_table_pri_dev)
  #dest_dev                        = "20.0.0.0/16"
  #manage-rt                       = concat(module.vpc-manage.route_table_pub, module.vpc-manage.route_table_pri_manage)
  #dest_manage                     = "10.0.0.0/16"
}
