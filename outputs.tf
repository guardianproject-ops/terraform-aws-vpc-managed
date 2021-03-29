output "vpc" {
  value = data.aws_vpc.default
}
output "vpc_id" {
  value = data.aws_vpc.default.id
}

output "subnet_private_1" {
  value = data.aws_subnet.private1.id
}

output "rds_subnet_ids" {
  value = [
    data.aws_subnet.private2.id,
    data.aws_subnet.private3.id
  ]
}

# we are only using the A subnets
# later we might expand to the B
output "private_subnet_ids" {
  value = local.subnet_ids
}

output "private_subnet_ids_all" {
  value = [
    data.aws_subnet.private1.id,
    data.aws_subnet.private1b.id,
    data.aws_subnet.private2.id,
    data.aws_subnet.private2b.id,
    data.aws_subnet.private3.id,
    data.aws_subnet.private3b.id
  ]
}

output "public_packer_subnet" {
  value = aws_subnet.packer_subnet
}


output "ssm_security_group" {
  value = aws_security_group.ssm_sg.id
}

output "vpc_endpoint_ssm" {
  value = aws_vpc_endpoint.ssm.id
}

output "vpc_endpoint_ec2messages" {
  value = aws_vpc_endpoint.ec2messages.id
}

output "vpc_endpoint_ssmmessages" {
  value = aws_vpc_endpoint.ssmmessages.id
}

output "vpc_endpoint_s3" {
  value = aws_vpc_endpoint.s3.id
}

output "vpc_endpoint_logs" {
  value = aws_vpc_endpoint.logs.id
}

output "vpc_endpoint_kms" {
  value = aws_vpc_endpoint.kms.id
}

output "availability_zones" {
  value = [
    data.aws_subnet.private1.availability_zone,
    data.aws_subnet.private2.availability_zone,
    data.aws_subnet.private3.availability_zone
  ]
}
