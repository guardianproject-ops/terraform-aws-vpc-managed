# AWS Control Tower manages the VPC we use
# So this module just finds and exports the ids for downstream module use

locals {
  vpc_id         = data.aws_vpc.default.id
  route_table_id = data.aws_vpc.default.main_route_table_id
  subnets = {
    "private1" : data.aws_subnet.private1,
    "private2" : data.aws_subnet.private2,
    "private3" : data.aws_subnet.private3
  }
  subnet_ids = [for subnet in local.subnets : subnet.id]

  use_nat_instance = var.nat_instance_forced ? true : ! var.is_prod_like
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "default" {
  tags = {
    "Name" : "aws-controltower-VPC"
  }
}


data "aws_subnet" "private1" {
  vpc_id = local.vpc_id

  tags = {
    "Name" : "aws-controltower-PrivateSubnet1A"
  }
}

data "aws_subnet" "private1b" {
  vpc_id = local.vpc_id

  tags = {
    "Name" : "aws-controltower-PrivateSubnet1B"
  }
}

data "aws_subnet" "private2" {
  vpc_id = local.vpc_id

  tags = {
    "Name" : "aws-controltower-PrivateSubnet2A"
  }
}

data "aws_subnet" "private2b" {
  vpc_id = local.vpc_id

  tags = {
    "Name" : "aws-controltower-PrivateSubnet2B"
  }
}

data "aws_subnet" "private3" {
  vpc_id = local.vpc_id

  tags = {
    "Name" : "aws-controltower-PrivateSubnet3A"
  }
}

data "aws_subnet" "private3b" {
  vpc_id = local.vpc_id

  tags = {
    "Name" : "aws-controltower-PrivateSubnet3B"
  }
}

## INERNET GATEWAY
# for internet egress

resource "aws_internet_gateway" "default" {
  vpc_id = local.vpc_id
  tags   = module.this.tags
}


## PACKER public subnet
# isolated packer builds

module "packer_subnet_label" {
  source     = "cloudposse/label/null"
  version    = "0.22.1"
  attributes = ["packer-build"]
  tags = {
    "Visibility"  = "public",
    "Application" = "packer"
  }
  context = module.this.context
}

resource "aws_subnet" "packer_subnet" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.packer_subnet_cidr_block
  availability_zone       = data.aws_subnet.private1.availability_zone
  map_public_ip_on_launch = true

  tags = merge(
    module.packer_subnet_label.tags,
    {
      "Name" = format(
        "%s%s%s",
        module.packer_subnet_label.id,
        module.this.delimiter,
        replace(
          data.aws_subnet.private1.availability_zone,
          "-",
          module.this.delimiter
        )
      )
    }
  )

  lifecycle {
    ignore_changes = [tags.Visibility]
  }
}

resource "aws_route" "packer_subnet" {
  route_table_id         = data.aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id

  timeouts {
    create = var.aws_route_create_timeout
    delete = var.aws_route_delete_timeout
  }
}

resource "aws_route_table_association" "packer_subnet" {
  subnet_id      = aws_subnet.packer_subnet.id
  route_table_id = data.aws_vpc.default.main_route_table_id
}


## NAT INSTANCE
# the nat instance gets its own public subnet
# a nat instance is cheaper than a NAT Gateway

module "nat_subnet_label" {
  source     = "cloudposse/label/null"
  version    = "0.22.1"
  attributes = ["nat-build"]
  tags = {
    "Visibility"  = "public",
    "Application" = "nat"
  }
  context = module.this.context
}

resource "aws_subnet" "nat_subnet" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.nat_subnet_cidr_block
  availability_zone       = data.aws_subnet.private1.availability_zone
  map_public_ip_on_launch = true

  tags = merge(
    module.nat_subnet_label.tags,
    {
      "Name" = format(
        "%s%s%s",
        module.nat_subnet_label.id,
        module.this.delimiter,
        replace(
          data.aws_subnet.private1.availability_zone,
          "-",
          module.this.delimiter
        )
      )
    }
  )

  lifecycle {
    ignore_changes = [tags.Visibility]
  }
}

resource "aws_route_table" "nat" {
  vpc_id = local.vpc_id

  tags = module.nat_subnet_label.tags
}


resource "aws_route" "nat_subnet" {
  route_table_id         = aws_route_table.nat.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id

  timeouts {
    create = var.aws_route_create_timeout
    delete = var.aws_route_delete_timeout
  }
}

resource "aws_route_table_association" "nat_subnet" {
  subnet_id      = aws_subnet.nat_subnet.id
  route_table_id = aws_route_table.nat.id
}

data "aws_route_table" "private1" {
  subnet_id = data.aws_subnet.private1.id
}


module "nat_instance" {
  source = "./nat-instance"

  count = var.disable_nat ? 0 : local.use_nat_instance ? 1 : 0

  vpc_id                   = local.vpc_id
  public_subnet_id         = aws_subnet.nat_subnet.id
  private_route_table_id   = data.aws_route_table.private1.id
  availability_zone        = data.aws_subnet.private1.availability_zone
  aws_route_create_timeout = var.aws_route_create_timeout
  aws_route_delete_timeout = var.aws_route_delete_timeout
  nat_instance_type        = var.nat_instance_type
  cidr_block               = data.aws_vpc.default.cidr_block
  attributes               = [data.aws_subnet.private1.availability_zone, "Private1A"]
  context                  = module.this.context
  enabled                  = true
}

module "nat_gateway" {
  source = "./nat-gateway"

  count = var.disable_nat ? 0 : local.use_nat_instance ? 0 : 1

  vpc_id                   = local.vpc_id
  public_subnet_id         = aws_subnet.nat_subnet.id
  private_route_table_id   = data.aws_route_table.private1.id
  aws_route_create_timeout = var.aws_route_create_timeout
  aws_route_delete_timeout = var.aws_route_delete_timeout
  attributes               = [data.aws_subnet.private1.availability_zone, "Private1A"]
  context                  = module.this.context
  enabled                  = true
}

### REGION SETTINGS PARAMS
locals {
  region_settings_prefix = "/${module.this.namespace}-${module.this.environment}-region-settings"
}
resource "aws_ssm_parameter" "vpc_id" {
  name  = "${local.region_settings_prefix}/default-vpc/vpc-id"
  type  = "String"
  value = local.vpc_id
  tags  = module.this.tags
}

resource "aws_ssm_parameter" "subnet1" {
  name  = "${local.region_settings_prefix}/default-vpc/subnet-private1-id"
  type  = "String"
  value = data.aws_subnet.private1.id
  tags  = module.this.tags
}

resource "aws_ssm_parameter" "subnet2" {
  name  = "${local.region_settings_prefix}/default-vpc/subnet-private2-id"
  type  = "String"
  value = data.aws_subnet.private2.id
  tags  = module.this.tags
}

resource "aws_ssm_parameter" "subnet3" {
  name  = "${local.region_settings_prefix}/default-vpc/subnet-private3-id"
  type  = "String"
  value = data.aws_subnet.private3.id
  tags  = module.this.tags
}
