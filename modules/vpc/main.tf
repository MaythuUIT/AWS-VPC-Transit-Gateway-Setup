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

# resource "aws_subnet" "public" {
#   count      = var.public_cidr_block != "" ? 1 : 0
#   vpc_id     = aws_vpc.this.id
#   cidr_block = var.public_cidr_block
#   availability_zone = var.availability_zone
#   map_public_ip_on_launch = true
#   tags = {
#     Name = "${var.name}-public-subnet"
#   }
# }

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "default" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = var.transit_gateway_id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# resource "aws_route_table" "public" {
#   count = var.public_cidr_block != "" ? 1 : 0
#   vpc_id = aws_vpc.this.id
# }


# resource "aws_route_table_association" "public" {
#   count          = var.public_cidr_block != "" ? 1 : 0
#   subnet_id      = aws_subnet.public[count.index].id
#   route_table_id = aws_route_table.public[count.index].id
# }

output "vpc_id" {
  value = aws_vpc.this.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

# output "public_subnet_id" {
#   value = length(aws_subnet.public) > 0 ? aws_subnet.public[0].id : null
# }
