locals {
  resource_name_prefix = var.namespace
}

data "aws_vpc" "customer_vpc" {
  id = var.vpc_id
}

resource "aws_cloudwatch_log_group" "flow_logs" {
  name              = "/${local.resource_name_prefix}/vpc-flowlogs"
  retention_in_days = 90
}

data "aws_iam_policy_document" "vpc_flowlog_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams"
    ]
    resources = [
      "arn:aws:logs:${var.aws_region}:${data.aws_vpc.customer_vpc.owner_id}:log-group:/${local.resource_name_prefix}/vpc-flowlogs:*"
    ]
  }
}

resource "aws_iam_policy" "vpc_flowlog_policy" {
  name   = "${var.namespace}-vpc-flowlog-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.vpc_flowlog_policy.json
}

resource "aws_iam_role" "flow_logs_role" {
  name = "${var.namespace}-vpc-flowlog-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "vpc-flow-logs.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy_attachment" "vpc_flowlog" {
  name       = "${var.namespace}-vpc-flowlog-role"
  roles      = [aws_iam_role.flow_logs_role.name]
  policy_arn = aws_iam_policy.vpc_flowlog_policy.arn
}

resource "aws_flow_log" "vpcflowlog" {
  iam_role_arn    = aws_iam_role.flow_logs_role.arn
  log_destination = aws_cloudwatch_log_group.flow_logs.arn
  traffic_type    = "ALL"
  vpc_id          = var.vpc_id
  tags = {
    Name = "${local.resource_name_prefix}-vpcflowlog"
  }
}
