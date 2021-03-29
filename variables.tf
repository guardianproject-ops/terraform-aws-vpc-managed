variable "is_prod_like" {
  type        = bool
  description = "Flag to indicate this module is prod like or not. Some behavior will be different in prod like envs"
}

variable "nat_instance_forced" {
  type        = bool
  default     = false
  description = "Set to true to force a nat instance (rather than nat gateway) even for a prod account"
}

variable "disable_nat" {
  type        = bool
  default     = false
  description = "Set to true to disable NAT for the private network"
}

variable "nat_subnet_cidr_block" {
  type        = string
  description = "the cidr block the public nat instance subnet will use"
}
variable "packer_subnet_cidr_block" {
  type        = string
  description = "the cidr block the public packer subnet will use"
}

variable "aws_route_create_timeout" {
  type        = string
  default     = "2m"
  description = "Time to wait for AWS route creation specifed as a Go Duration, e.g. `2m`"
}

variable "aws_route_delete_timeout" {
  type        = string
  default     = "5m"
  description = "Time to wait for AWS route deletion specifed as a Go Duration, e.g. `5m`"
}

variable "nat_instance_type" {
  type        = string
  description = "NAT Instance type"
  default     = "t3.micro"
}

