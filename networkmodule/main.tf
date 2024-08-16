# VPC Resource
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Public Subnets
resource "aws_subnet" "publicsubnet_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.publicsubnet_1_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_1
  tags = {
    Name = "${var.vpc_name}-public-subnet-1"
  }
}

resource "aws_subnet" "publicsubnet_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.publicsubnet_2_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_2
  tags = {
    Name = "${var.vpc_name}-public-subnet-2"
  }
}

resource "aws_subnet" "publicsubnet_3" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.publicsubnet_3_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_3
  tags = {
    Name = "${var.vpc_name}-public-subnet-3"
  }
}


# Private Subnets
resource "aws_subnet" "privatesubnet_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.privatesubnet_1_cidr
  availability_zone = var.availability_zone_1
  tags = {
    Name = "${var.vpc_name}-private-subnet-1"
  }
}

resource "aws_subnet" "privatesubnet_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.privatesubnet_2_cidr
  availability_zone = var.availability_zone_2
  tags = {
    Name = "${var.vpc_name}-private-subnet-2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# NAT Gateway and Elastic IP
resource "aws_eip" "natgw" {
  domain = "vpc"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = aws_eip.natgw.id
  subnet_id     = aws_subnet.publicsubnet_1.id
  tags = {
    Name = "${var.vpc_name}-natgw"
  }
}

# Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-public-route-table"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-private-route-table"
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
}

# Route Table Associations
resource "aws_route_table_association" "publicsubnet_1" {
  subnet_id      = aws_subnet.publicsubnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "publicsubnet_2" {
  subnet_id      = aws_subnet.publicsubnet_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "privatesubnet_1" {
  subnet_id      = aws_subnet.privatesubnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "privatesubnet_2" {
  subnet_id      = aws_subnet.privatesubnet_2.id
  route_table_id = aws_route_table.private.id
}

# Security Groups
resource "aws_security_group" "bastion_sg" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-bastion-sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-private-sg"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
