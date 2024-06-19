
# Cloud provider
provider "aws" {
    region = var.location
}


# VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
}


# internet gateway
resource "aws_internet_gateway" "my_igw" {
    vpc_id = aws_vpc.my_vpc.id
}


# public subnet
resource "aws_subnet" "public_subnet_1" {
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block        = "10.0.1.0/24"
    availability_zone = var.location
}

resource "aws_subnet" "public_subnet_2" {
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block        = "10.0.2.0/24"
    availability_zone = var.location
}

# private subnets
resource "aws_subnet" "private_subnet_1" {
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block        = "10.0.3.0/24"
    availability_zone = var.location
}


resource "aws_subnet" "private_subnet_2" {
    vpc_id            = aws_vpc.my_vpc.id
    cidr_block        = "10.0.4.0/24"
    availability_zone = var.location
}


# security group
resource "aws_security_group" "my_sg" {
    name        = "my-security-group"
    description = "My custom security group"
    vpc_id      = aws_vpc.my_vpc.id


    # ingress rules
    ingress {
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    # egress rules
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
