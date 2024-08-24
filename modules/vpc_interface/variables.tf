#////////////////////////////////////////////////////////////////////////////////////////
# AUTHOR          : Leong Qin Yan
# DESCRIPTION     : VPC Interface Endpoint for AWS Services variables definition
#
# Variables used to spin up VPC Interface Endpoint to AWS service
#
# CHANGE LOG
# 03-Sep-2019      Leong Qin Yan              Created file
#////////////////////////////////////////////////////////////////////////////////////////
variable "vpc_id" {
  description = "VPC ID"
}

# Variable for agency 3 letter code
#variable "dept_code" {
# description = "The Department Code"
#}

variable "zone_name" {
  description = "code for zone - ez,iz,mz,dz"
}

# Variable for environment
variable "env_name" {
  description = "uat,prd,dev,sit,stg"
}

# Variable for project_code
variable "project_code" {
  description = "project code"
}

variable "project" {
  description = "project"
}

variable "billing_environment" {
  description = "billing environment"
}

variable "service_name" {
  description = "The service name, in the form com.amazonaws.region.service for AWS services."
}

variable "sg_ids" {
  type = list
  description = "The ID of one or more security groups to associate with the network interface. "
}

variable "purpose" {
  description = "purpose of the security group"
}

variable "private_dns_enabled" {
  description = "true|false"
}

variable "vpce_subnet_ids" {
  type = list
  description = "list of subnet ids"
}

variable "ep_tier" {
  description = "ep tier either epe or ep"
}


