# modules/vpc_c/main.tf

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.name}-vpc"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.private_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.name}-private-subnet"
  }
}

resource "aws_subnet" "public" {
  //count      = var.public_cidr_block != "" ? 1 : 0
  vpc_id     = aws_vpc.this.id
  cidr_block = var.public_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name}-public-subnet"
  }
}


resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  route {
    cidr_block           = var.vpc_a_cidr_block
    transit_gateway_id   = var.transit_gateway_id
  }

  route {
    cidr_block           = var.vpc_b_cidr_block
    transit_gateway_id   = var.transit_gateway_id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Create the Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id =aws_vpc.this.id
  tags = {
    Name = "internet-gateway"
  }
}

# Create the NAT Gateway
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "nat-gateway"
  }
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "public_subnet_id" {
  value =aws_subnet.public.id
}
