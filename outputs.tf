output "vpc_id" {
  value = "${module.management-vpc.vpc_id}"
}


output "CW_logGroup" {
  value = "${module.vpc-configs.log-group-arn}"
}
