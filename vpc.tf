
#vpc
resource "aws_vpc" "vpc1" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "${var.client_id}_vpc1"
    managed_by = var.managed_by
  }
}

#internet gateway
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id 
  
  tags = {
    Name = "${var.client_id}_igw1"
    managed_by = var.managed_by
  }
}

#public subnet
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name       = "${var.client_id}_public_subnet1"
    managed_by = var.managed_by
  }
}

#private subnet
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "${var.client_id}_private_subnet1"
    managed_by = var.managed_by
  }
}

#public route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "${var.client_id}_public_rt1"
    managed_by = var.managed_by
  }
}
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
}

#private route table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc1.id


  tags = {
    Name = "${var.client_id}_private_rt1"
    managed_by = var.managed_by
  }
}
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rt.id
}
