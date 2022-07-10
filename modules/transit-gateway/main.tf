locals {
  resource_name_prefix = var.namespace
}

resource "aws_ec2_transit_gateway" "this" {
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments
  default_route_table_association = var.default_route_table_association
  default_route_table_propagation = var.default_route_table_propagation
  dns_support                     = var.dns_support
  vpn_ecmp_support                = var.vpn_ecmp_support
  transit_gateway_cidr_blocks     = var.transit_gateway_cidr_blocks
  tags = {
    Name = "${local.resource_name_prefix}-TGW"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attachment-1" {
  subnet_ids         = var.subnet_dev
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = var.vpc_id_dev
  tags = {
    Name = "${local.resource_name_prefix}-dev-attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attachment-2" {
  subnet_ids         = var.subnet_manage
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = var.vpc_id_manage
  tags = {
    Name = "${local.resource_name_prefix}-manage-attachment"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "attachment-3" {
  subnet_ids         = var.subnet_prod
  transit_gateway_id = aws_ec2_transit_gateway.this.id
  vpc_id             = var.vpc_id_prod
  tags = {
    Name = "${local.resource_name_prefix}-prod-attachment"
  }
}

######## define aws_route to update the vpc route table entries with transit gateway id
resource "aws_route" "dev-a-1" {
  transit_gateway_id     = aws_ec2_transit_gateway.this.id
  route_table_id         = var.rt_table_dev_a
  for_each 		 = toset(var.dest_dev)
  destination_cidr_block = each.key
}

resource "aws_route" "manage-a-1" {
  transit_gateway_id     = aws_ec2_transit_gateway.this.id
  route_table_id         = var.rt_table_manage_a
  for_each		 = toset(var.dest_manage)
  destination_cidr_block = each.key
}

resource "aws_route" "manage-d-1" {
  transit_gateway_id     = aws_ec2_transit_gateway.this.id
  route_table_id         = var.rt_table_manage_d
  for_each		 = toset(var.dest_manage)
  destination_cidr_block = each.key
}

resource "aws_route" "manage-c-1" {
  transit_gateway_id     = aws_ec2_transit_gateway.this.id
  route_table_id         = var.rt_table_manage_c
  for_each		 = toset(var.dest_manage)
  destination_cidr_block = each.key
}

resource "aws_route" "prod-a-1" {
  transit_gateway_id     = aws_ec2_transit_gateway.this.id
  route_table_id         = var.rt_table_prod_a
  for_each		 = toset(var.dest_prod)
  destination_cidr_block = each.key
}
