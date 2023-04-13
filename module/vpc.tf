#VPC
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  tags                 = var.tags
}


#Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = merge(var.tags,
    {
      "Name" = "EC2_RDS Public Subnet ${count.index + 1}"
    }
  )
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_subnets_cidr)
  cidr_block        = element(var.private_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(var.tags,
    {
      "Name" = "EC2_RDS Private Subnet ${count.index + 1}"
    }
  )
}


#IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags,
    {
      "Name" = "EC2_RDS IGW"
    }
  )
}


#EIP
resource "aws_eip" "eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]
}


#NATGW
resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = element(aws_subnet.public.*.id, 0) //puts nat in a public subnet

}


#Route, makes public subnet public using main rt
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


#Second Route Table
resource "aws_route_table" "second_rt_private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = merge(var.tags,
    {
      Name = "EC2_RDS Second Route Table-Private"
    }
  )
}

resource "aws_route_table_association" "private_subnet_assoc" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.second_rt_private.id
}