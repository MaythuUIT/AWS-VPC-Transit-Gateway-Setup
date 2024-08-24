module "ec2_a" {
  source      = "./modules/ec2"
  name        = "ec2-a"
  subnet_id   = module.vpc_a.private_subnet_id
}

module "ec2_b" {
  source      = "./modules/ec2"
  name        = "ec2-b"
  subnet_id   = module.vpc_b.private_subnet_id
}
