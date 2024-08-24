
resource "aws_vpc_endpoint" "vpce_interface" {
  vpc_id              = var.vpc_id
  service_name        = var.service_name
  security_group_ids  = var.sg_ids
  vpc_endpoint_type   = "Interface"
  subnet_ids = var.vpce_subnet_ids
  private_dns_enabled = var.private_dns_enabled
    tags = {
    Name                      = format("vpce-%[1]s-%[2]s%[3]s-%[4]s-%[5]s",var.project_code,var.env_name,var.zone_name,var.ep_tier,var.purpose)
    Project                   = var.project
    "sal:billing:environment" = var.billing_environment
    Terraform                 = true
  }
}

locals {
  aws_vpc_endpoint_name = aws_vpc_endpoint.vpce_interface.dns_entry[*]
}

output "dns_entry" {
value = local.aws_vpc_endpoint_name[*]
}
