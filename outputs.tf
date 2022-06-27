output "vpc_id_dev" {
  value = "${module.vpc-dev.vpc_id}"
}


output "CW_logGroup_dev" {
  value = "${module.vpc-dev-configs.log-group-arn}"
}

output "vpc_id_manage" {
  value = "${module.vpc-manage.vpc_id}"
}


output "CW_logGroup_manage" {
  value = "${module.vpc-manage-configs.log-group-arn}"
}

