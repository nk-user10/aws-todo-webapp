#-----------------------------
#VPC
#-----------------------------

resource "aws_vpc" "main" {
  cidr_block           = local.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project}-${var.enviroment}-vpc"
  }
}

#------------------------
#subnet
#------------------------
resource "aws_subnet" "public" {
  count             = length(local.public_subnet_cider_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(local.public_subnet_cider_blocks, count.index)
  availability_zone = element(local.availability_zones, count.index)

  tags = {
    Name = "${var.project}-${var.enviroment}-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count             = length(local.private_subnet_cider_blocks)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(local.private_subnet_cider_blocks, count.index)
  availability_zone = element(local.availability_zones, count.index)

  tags = {
    Name = "${var.project}-${var.enviroment}-private-subnet-${count.index}"
  }
}
