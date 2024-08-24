resource "aws_ec2_transit_gateway" "this" {
  description = "Transit Gateway for VPC connectivity"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_a" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = var.vpc_a_id
  subnet_ids          = [var.vpc_a_subnet_id]
  tags_all = {
    Name ="VPC-A-attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_b" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = var.vpc_b_id
  subnet_ids          = [var.vpc_b_subnet_id]
  tags_all = {
    Name ="VPC-B-attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_c" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = var.vpc_c_id
  subnet_ids          = [var.vpc_c_subnet_id]
  tags_all = {
    Name ="VPC-C-attachment"
  }
}

resource "aws_ec2_transit_gateway_route_table" "vpc_a" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
    tags_all = {
    Name ="VPC-A-routetable"
  }
}

resource "aws_ec2_transit_gateway_route" "vpc_a_to_b" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_a.id
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_b.id
}

resource "aws_ec2_transit_gateway_route" "vpc_a_default" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_a.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_c.id
}

resource "aws_ec2_transit_gateway_route_table" "vpc_b" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
    tags_all = {
    Name ="VPC-B-routetable"
  }
}

resource "aws_ec2_transit_gateway_route" "vpc_b_to_a" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_b.id
  destination_cidr_block = "10.0.0.0/16"
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_a.id
}

resource "aws_ec2_transit_gateway_route" "vpc_b_default" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_b.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_c.id
}

resource "aws_ec2_transit_gateway_route_table" "vpc_c" {
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  tags_all = {
    Name ="VPC-C-routetable"
  }
}

resource "aws_ec2_transit_gateway_route" "vpc_c_to_a" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_c.id
  destination_cidr_block = "10.0.0.0/16"
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_a.id
}

resource "aws_ec2_transit_gateway_route" "vpc_c_to_b" {
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_c.id
  destination_cidr_block = "10.1.0.0/16"
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.vpc_b.id
}



//route table associaton 

resource "aws_ec2_transit_gateway_route_table_association" "vpc-a-routetable-association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc_a.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_a.id
}


resource "aws_ec2_transit_gateway_route_table_association" "vpc-b-routetable-association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc_b.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_b.id
}


resource "aws_ec2_transit_gateway_route_table_association" "vpc-c-routetable-association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpc_c.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.vpc_c.id
}


#disassociation from defaultroutetable

output "transit_gateway_id" {
  value = aws_ec2_transit_gateway.this.id
}
