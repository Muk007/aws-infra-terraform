locals {
  resource_name_prefix = "${var.namespace}"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  instance_tenancy     = "default"
  tags = {
    Name = "${local.resource_name_prefix}-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  count                   = "${var.namespace == "management" ? length(var.subnet_cidr) : 0}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.subnet_cidr[count.index]}"
  map_public_ip_on_launch = "true"
  availability_zone       = "${var.avail_zone[count.index]}"
  tags = {
    Name = "${local.resource_name_prefix}-publicSubnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  count  = "${var.namespace == "management" ? 1 : 0}"
  vpc_id = "${aws_vpc.vpc.id}"
  tags = {
    Name = "${local.resource_name_prefix}-igw"
  }
}

resource "aws_route_table" "public-rt" {
  count  = "${var.namespace == "management" ? length(var.subnet_cidr) : 0}"
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "${var.global_ip}"
    gateway_id = "${element(aws_internet_gateway.igw.*.id, count.index)}"
  }
  tags = {
    Name = "${local.resource_name_prefix}-publicRouteTable-${count.index + 1}"
  }
}

resource "aws_route_table_association" "rt-public-subnet-association" {
  count          = "${var.namespace == "management" ? length(var.subnet_cidr) : 0}"
  subnet_id      = "${element(aws_subnet.public-subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public-rt.*.id, count.index)}"
}

resource "aws_subnet" "private-subnet" {
  count             = length(var.private_subnet_cidr)
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.private_subnet_cidr[count.index]}"
  availability_zone = "${var.private_avail_zone[count.index]}"
  tags = {
    Name = "${local.resource_name_prefix}-privateSubnet-${count.index + 1}"
  }
}

resource "aws_route_table" "private-rt" {
  count  = "${var.namespace == "management" ? length(var.private_subnet_cidr) : 0}"
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block     = "${var.global_ip}"
    nat_gateway_id = "${element(aws_nat_gateway.gw.*.id, count.index)}"
  }
  tags = {
    Name = "${local.resource_name_prefix}-privateRouteTable-${count.index + 1}"
  }
}

resource "aws_eip" "nat" {
  count = "${var.namespace == "management" ? length(var.private_subnet_cidr) : 0}"
  vpc   = "true"
  tags = {
    Name = "${local.resource_name_prefix}-natGW-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "gw" {
  count         = "${var.namespace == "management" ? length(var.private_subnet_cidr) : 0}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public-subnet.*.id, count.index)}"
  tags = {
    Name = "${local.resource_name_prefix}-natGW-${count.index + 1}"
  }
}

resource "aws_route_table_association" "rt-private-subnet-association" {
  count          = "${var.namespace == "management" ? length(var.subnet_cidr) : 0}"
  subnet_id      = "${element(aws_subnet.private-subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private-rt.*.id, count.index)}"
}
