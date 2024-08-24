module "vpc_a" {
  source             = "./modules/vpc"
  name               = "vpc-a"
  cidr_block         = "10.0.0.0/16"
  private_cidr_block = "10.0.1.0/24"
  availability_zone  = "ap-southeast-1a"
  transit_gateway_id = module.transit_gateway.transit_gateway_id
}

module "vpc_b" {
  source             = "./modules/vpc"
  name               = "vpc-b"
  cidr_block         = "10.1.0.0/16"
  private_cidr_block = "10.1.1.0/24"
  availability_zone  = "ap-southeast-1b"
  transit_gateway_id = module.transit_gateway.transit_gateway_id
}

# module "vpc_c" {
#   source             = "./modules/vpc"
#   name               = "vpc-c"
#   cidr_block         = "10.2.0.0/16"
#   private_cidr_block = "10.2.1.0/24"
#   public_cidr_block  = "10.2.0.0/24"
#   availability_zone  = "ap-southeast-1c"
#   transit_gateway_id = module.transit_gateway.transit_gateway_id
# }


module "vpc_c" {
  source               = "./modules/vpc_c"
  name               = "vpc-c"
  cidr_block         = "10.2.0.0/16"
  private_cidr_block = "10.2.1.0/24"
  public_cidr_block  = "10.2.2.0/24"
  availability_zone  = "ap-southeast-1c"
  transit_gateway_id = module.transit_gateway.transit_gateway_id
  vpc_a_cidr_block     = "10.0.0.0/16"
  vpc_b_cidr_block     = "10.1.0.0/16"
}


