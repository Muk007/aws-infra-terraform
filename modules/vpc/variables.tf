variable "cidr" {
  type    = string
}

variable "subnet_cidr" {
  type    = list(string)
}

variable "private_subnet_cidr" {
  type    = list(string)
}

variable "avail_zone" {
  type    = list(string)
}

variable "private_avail_zone" {
  type    = list(string)
}

variable "global_ip" {
  type    = string
}


variable "namespace" {
  type        = string
  description = "Namespace"
}
