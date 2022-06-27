variable "namespace" {
  type        = string
  default     = "management"
  description = "Namespace"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Target region"
}

variable "vpc_id" {
  type        = string
  description = "Associated VPC ID"
}
