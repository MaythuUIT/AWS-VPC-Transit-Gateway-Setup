module "transit_gateway" {
  source          = "./modules/transit_gateway"
  vpc_a_id        = module.vpc_a.vpc_id
  vpc_a_subnet_id = module.vpc_a.private_subnet_id
  vpc_b_id        = module.vpc_b.vpc_id
  vpc_b_subnet_id = module.vpc_b.private_subnet_id
  vpc_c_id        = module.vpc_c.vpc_id
  vpc_c_subnet_id = module.vpc_c.private_subnet_id
}