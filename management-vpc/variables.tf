variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr" {
  type    = list(string)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "avail_zone" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b"]
}

variable "private_avail_zone" {
  type    = list(string)
  default = ["us-east-1c", "us-east-1d"]
}

variable "global_ip" {
  type    = string
  default = "0.0.0.0/0"
}


variable "namespace" {
  type        = string
  default     = "management"
  description = "Namespace"
}
