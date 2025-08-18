resource "aws_vpc" "example_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "example_subnets" {
  count                   = length(var.subnet_cidr_blocks)
  vpc_id                  = aws_vpc.example_vpc.id
  cidr_block              = element(var.subnet_cidr_blocks, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = element(var.subnet_names, count.index)
  }
}


resource "aws_internet_gateway" "example_igw" {
  vpc_id = aws_vpc.example_vpc.id
  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "example_rt" {
  vpc_id = aws_vpc.example_vpc.id
  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route" "example_route" {
  route_table_id         = aws_route_table.example_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.example_igw.id
}

resource "aws_route_table_association" "example_rta" {
  count          = length(aws_subnet.example_subnets[*].id)
  subnet_id      = element(aws_subnet.example_subnets[*].id, count.index)
  route_table_id = aws_route_table.example_rt.id
}
