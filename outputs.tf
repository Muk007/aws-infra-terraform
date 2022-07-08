output "vpc_id_dev" {
  value = module.vpc-dev.vpc_id
}


output "CW_logGroup_dev" {
  value = module.vpc-dev-configs.log-group-arn
}

output "vpc_id_manage" {
  value = module.vpc-manage.vpc_id
}


output "CW_logGroup_manage" {
  value = module.vpc-manage-configs.log-group-arn
}

output "route_table_id_dev_private" {
  value = module.vpc-dev.route_table_pri_dev
}

output "route_table_id_dev_public" {
  value = module.vpc-dev.route_table_pub
}

output "route_table_id_manage_private" {
  value = module.vpc-manage.route_table_pri_manage
}

output "route_table_id_manage_public" {
  value = module.vpc-manage.route_table_pub
}

output "subnet_id_dev_private" {
  value = module.vpc-dev.subnet_pri
}

output "subnet_id_dev_public" {
  value = module.vpc-dev.subnet_pub
}

output "subnet_id_manage_private" {
  value = module.vpc-manage.subnet_pri
}

output "subnet_id_manage_public" {
  value = module.vpc-manage.subnet_pub
}

#output "transit_gateway_id" {
#  value = module.transit-gateway.TGW_id
#}
