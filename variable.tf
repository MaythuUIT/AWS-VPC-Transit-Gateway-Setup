variable "region" {
  description = "The AWS region where the infrastructure will be deployed."
  type        = string
}

variable "vpc_a_cidr" {
  description = "CIDR block for VPC A"
  type        = string
}

variable "vpc_a_subnet_cidr" {
  description = "CIDR block for VPC A's subnet"
  type        = string
}

variable "vpc_b_cidr" {
  description = "CIDR block for VPC B"
  type        = string
}

variable "vpc_b_subnet_cidr" {
  description = "CIDR block for VPC B's subnet"
  type        = string
}

variable "vpc_c_cidr" {
  description = "CIDR block for VPC C"
  type        = string
}

variable "vpc_c_subnet_cidr" {
  description = "CIDR block for VPC C's subnet"
  type        = string
}

variable "az" {
  description = "Availability zone for the subnets"
  type        = string
}
