module "endpoint_label" {
  source     = "cloudposse/label/null"
  version    = "0.22.1"
  attributes = ["ssm-endp"]
  context    = module.this.context
}

data "aws_route_table" "selected" {
  for_each  = local.subnets
  subnet_id = each.value.id
}

# Create VPC Endpoints For Session Manager and Secrets Manager
resource "aws_security_group" "ssm_sg" {
  name        = module.endpoint_label.id
  description = "Allow TLS inbound To AWS Systems Manager Session Manager"
  vpc_id      = local.vpc_id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      for subnet in local.subnets : subnet.cidr_block
    ]
  }

  egress {
    description = "Allow All Egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = module.endpoint_label.tags
}

# SSM, EC2Messages, and SSMMessages endpoints are required for Session Manager
resource "aws_vpc_endpoint" "ssm" {
  vpc_id            = local.vpc_id
  subnet_ids        = local.subnet_ids
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssm"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ssm_sg.id
  ]

  private_dns_enabled = true
  tags                = module.endpoint_label.tags
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id            = local.vpc_id
  subnet_ids        = local.subnet_ids
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ec2messages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ssm_sg.id
  ]

  private_dns_enabled = true
  tags                = module.endpoint_label.tags
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id            = local.vpc_id
  subnet_ids        = local.subnet_ids
  service_name      = "com.amazonaws.${data.aws_region.current.name}.ssmmessages"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ssm_sg.id
  ]

  private_dns_enabled = true
  tags                = module.endpoint_label.tags
}

# To write session logs to S3, an S3 endpoint is needed:
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = local.vpc_id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
  tags         = module.endpoint_label.tags
}

# Associate S3 Gateway Endpoint to VPC and Subnets 
resource "aws_vpc_endpoint_route_table_association" "private_s3_route" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = local.route_table_id
}

resource "aws_vpc_endpoint_route_table_association" "private_s3_subnet_route" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = local.route_table_id
}


# To write session logs to CloudWatch, a CloudWatch endpoint is needed
resource "aws_vpc_endpoint" "logs" {
  vpc_id            = local.vpc_id
  subnet_ids        = local.subnet_ids
  service_name      = "com.amazonaws.${data.aws_region.current.name}.logs"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ssm_sg.id
  ]

  private_dns_enabled = true
  tags                = module.endpoint_label.tags
}

# To Encrypt/Decrypt, a KMS endpoint is needed
resource "aws_vpc_endpoint" "kms" {
  vpc_id            = local.vpc_id
  subnet_ids        = local.subnet_ids
  service_name      = "com.amazonaws.${data.aws_region.current.name}.kms"
  vpc_endpoint_type = "Interface"

  security_group_ids = [
    aws_security_group.ssm_sg.id
  ]

  private_dns_enabled = true
  tags                = module.endpoint_label.tags
}

# add an endpoint for secretsmanager so our ssh rotation lambda can access it
resource "aws_security_group" "ssm_secretsmanager" {
  name        = "${module.endpoint_label.id}-secretsmanager"
  description = "Allow TLS inbound To AWS Secrets Manager"
  vpc_id      = local.vpc_id

  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      for subnet in local.subnets : subnet.cidr_block
    ]
  }

  tags = module.endpoint_label.tags
}
data "aws_vpc_endpoint_service" "secretsmanager" {
  service = "secretsmanager"
}

resource "aws_vpc_endpoint" "secretsmanager" {
  vpc_id            = local.vpc_id
  service_name      = data.aws_vpc_endpoint_service.secretsmanager.service_name
  vpc_endpoint_type = "Interface"
  subnet_ids        = local.subnet_ids
  security_group_ids = [
    aws_security_group.ssm_secretsmanager.id
  ]
  private_dns_enabled = true
  tags                = module.endpoint_label.tags
}
