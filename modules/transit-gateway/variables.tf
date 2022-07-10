variable "namespace" {
  type        = string
  description = "Namespace"
  default     = "Terraform"
}

variable "vpc_id_dev" {
  type        = string
  description = "VPC Id for dev"
}

variable "vpc_id_manage" {
  type        = string
  description = "VPC Id for manage"
}

variable "vpc_id_prod" {
  type = string
}

variable "transit_gateway_cidr_blocks" {
  type        = list(string)
  description = "cidr for TGW, pass this value as null"
  default     = null
}

variable "vpn_ecmp_support" {
  type        = string
  description = ""
  default     = "enable"
}

variable "dns_support" {
  type        = string
  description = ""
  default     = "enable"
}

variable "default_route_table_propagation" {
  type        = string
  description = ""
  default     = "enable"
}

variable "default_route_table_association" {
  type        = string
  description = ""
  default     = "enable"
}

variable "auto_accept_shared_attachments" {
  type        = string
  description = ""
  default     = "disable"
}

variable "subnet_dev" {
  type        = list(string)
  description = ""
}

variable "subnet_manage" {
  type        = list(string)
  description = ""
}

variable "subnet_prod" {
  type = list(string)
}

############# aws route variables

variable "rt_table_dev_a" {
  type = string
}

variable "dest_dev" {
  type = list(string)
}

variable "rt_table_manage_a" {
  type = string
}

#variable "rt_table_manage_b" {
#  type = string
#}

variable "rt_table_manage_c" {
  type = string
}

variable "rt_table_manage_d" {
  type = string
}

variable "dest_manage" {
  type = list(string)
}

variable "rt_table_prod_a" {
  type = string
}

variable "dest_prod" {
  type = list(string)
}
