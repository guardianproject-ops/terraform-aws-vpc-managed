terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      # TODO: remove 3.26.0 pin when this issue is solved https://github.com/hashicorp/terraform-provider-aws/issues/17353
      version = ">= 2.0,< 3.26.0"
    }
  }
}
