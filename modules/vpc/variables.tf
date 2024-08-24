variable "name" {}
variable "cidr_block" {}
variable "private_cidr_block" {}
variable "public_cidr_block" {
  description = "CIDR block for the public subnet"
  default     = ""
}
variable "availability_zone" {}
variable "transit_gateway_id" {}
