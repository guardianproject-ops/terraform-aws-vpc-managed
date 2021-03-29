<!-- 














  ** DO NOT EDIT THIS FILE
  ** 
  ** This file was automatically generated by the `build-harness`. 
  ** 1) Make all changes to `README.yaml` 
  ** 2) Run `make init` (you only need to do this once)
  ** 3) Run`make readme` to rebuild this file. 
  **
  ** (We maintain HUNDREDS of open source projects. This is how we maintain our sanity.)
  **















  -->

# terraform-aws-vpc-managed



This is a terraform module that creates public and private subnets with
optional nat instances or gateways, but it does not create the VPC. It is
designed to be used with AWS Control Tower managed VPCs.


---


This project is part of the [Guardian Project Ops](https://gitlab.com/guardianproject-ops/) collection.


It's free and open source made available under the the [APACHE2](LICENSE.md).











## Introduction


The VPC, nat-gateway, and nat-instance submodules are based off of
Cloudposse's  [vpc](https://github.com/cloudposse/terraform-aws-vpc)  and
[dynamic-subnets](https://github.com/cloudposse/terraform-aws-dynamic-subnets)
modules.



## Usage


**IMPORTANT:** The `master` branch is used in `source` just as an example. In your code, do not pin to `master` because there may be breaking changes between releases.
Instead pin to the release tag (e.g. `?ref=tags/x.y.z`) of one of our [latest releases](https://gitlab.com/guardianproject-ops/terraform-aws-vpc-managed/-/tags).



```hcl
module "vpc" {
  source = "git::https://gitlab.com/guardianproject-ops/terraform-aws-vpc-managed?ref=master"

  packer_subnet_cidr_block = "10.0.0.0/24"
  nat_subnet_cidr_block    = "10.0.1.0/24"
}

```






## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0,< 3.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0,< 3.26.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_endpoint_label"></a> [endpoint\_label](#module\_endpoint\_label) | cloudposse/label/null | 0.22.1 |
| <a name="module_nat_gateway"></a> [nat\_gateway](#module\_nat\_gateway) | ./nat-gateway |  |
| <a name="module_nat_instance"></a> [nat\_instance](#module\_nat\_instance) | ./nat-instance |  |
| <a name="module_nat_subnet_label"></a> [nat\_subnet\_label](#module\_nat\_subnet\_label) | cloudposse/label/null | 0.22.1 |
| <a name="module_packer_subnet_label"></a> [packer\_subnet\_label](#module\_packer\_subnet\_label) | cloudposse/label/null | 0.22.1 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.22.1 |

## Resources

| Name | Type |
|------|------|
| [aws_internet_gateway.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route.nat_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.packer_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.nat_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.packer_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.ssm_secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ssm_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ssm_parameter.subnet1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.subnet2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.subnet3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.vpc_id](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_subnet.nat_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.packer_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc_endpoint.ec2messages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.kms](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.ssmmessages](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint_route_table_association.private_s3_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_vpc_endpoint_route_table_association.private_s3_subnet_route](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint_route_table_association) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_route_table.private1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_route_table.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route_table) | data source |
| [aws_subnet.private1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.private1b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.private2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.private2b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.private3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.private3b](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [aws_vpc_endpoint_service.secretsmanager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc_endpoint_service) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional tags for appending to tags\_as\_list\_of\_maps. Not added to `tags`. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| <a name="input_aws_route_create_timeout"></a> [aws\_route\_create\_timeout](#input\_aws\_route\_create\_timeout) | Time to wait for AWS route creation specifed as a Go Duration, e.g. `2m` | `string` | `"2m"` | no |
| <a name="input_aws_route_delete_timeout"></a> [aws\_route\_delete\_timeout](#input\_aws\_route\_delete\_timeout) | Time to wait for AWS route deletion specifed as a Go Duration, e.g. `5m` | `string` | `"5m"` | no |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | <pre>object({<br>    enabled             = bool<br>    namespace           = string<br>    environment         = string<br>    stage               = string<br>    name                = string<br>    delimiter           = string<br>    attributes          = list(string)<br>    tags                = map(string)<br>    additional_tag_map  = map(string)<br>    regex_replace_chars = string<br>    label_order         = list(string)<br>    id_length_limit     = number<br>  })</pre> | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_order": [],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {}<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_disable_nat"></a> [disable\_nat](#input\_disable\_nat) | Set to true to disable NAT for the private network | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment, e.g. 'uw2', 'us-west-2', OR 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters.<br>Set to `0` for unlimited length.<br>Set to `null` for default, which is `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_is_prod_like"></a> [is\_prod\_like](#input\_is\_prod\_like) | Flag to indicate this module is prod like or not. Some behavior will be different in prod like envs | `bool` | n/a | yes |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The naming order of the id output and Name tag.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 5 elements, but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Solution name, e.g. 'app' or 'jenkins' | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp' | `string` | `null` | no |
| <a name="input_nat_instance_forced"></a> [nat\_instance\_forced](#input\_nat\_instance\_forced) | Set to true to force a nat instance (rather than nat gateway) even for a prod account | `bool` | `false` | no |
| <a name="input_nat_instance_type"></a> [nat\_instance\_type](#input\_nat\_instance\_type) | NAT Instance type | `string` | `"t3.micro"` | no |
| <a name="input_nat_subnet_cidr_block"></a> [nat\_subnet\_cidr\_block](#input\_nat\_subnet\_cidr\_block) | the cidr block the public nat instance subnet will use | `string` | n/a | yes |
| <a name="input_packer_subnet_cidr_block"></a> [packer\_subnet\_cidr\_block](#input\_packer\_subnet\_cidr\_block) | the cidr block the public packer subnet will use | `string` | n/a | yes |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `map('BusinessUnit','XYZ')` | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | n/a |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | we are only using the A subnets later we might expand to the B |
| <a name="output_private_subnet_ids_all"></a> [private\_subnet\_ids\_all](#output\_private\_subnet\_ids\_all) | n/a |
| <a name="output_public_packer_subnet"></a> [public\_packer\_subnet](#output\_public\_packer\_subnet) | n/a |
| <a name="output_rds_subnet_ids"></a> [rds\_subnet\_ids](#output\_rds\_subnet\_ids) | n/a |
| <a name="output_ssm_security_group"></a> [ssm\_security\_group](#output\_ssm\_security\_group) | n/a |
| <a name="output_subnet_private_1"></a> [subnet\_private\_1](#output\_subnet\_private\_1) | n/a |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | n/a |
| <a name="output_vpc_endpoint_ec2messages"></a> [vpc\_endpoint\_ec2messages](#output\_vpc\_endpoint\_ec2messages) | n/a |
| <a name="output_vpc_endpoint_kms"></a> [vpc\_endpoint\_kms](#output\_vpc\_endpoint\_kms) | n/a |
| <a name="output_vpc_endpoint_logs"></a> [vpc\_endpoint\_logs](#output\_vpc\_endpoint\_logs) | n/a |
| <a name="output_vpc_endpoint_s3"></a> [vpc\_endpoint\_s3](#output\_vpc\_endpoint\_s3) | n/a |
| <a name="output_vpc_endpoint_ssm"></a> [vpc\_endpoint\_ssm](#output\_vpc\_endpoint\_ssm) | n/a |
| <a name="output_vpc_endpoint_ssmmessages"></a> [vpc\_endpoint\_ssmmessages](#output\_vpc\_endpoint\_ssmmessages) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | n/a |



## Share the Love 

Like this project? Please give it a ★ on [GitLab](https://gitlab.com/guardianproject-ops/terraform-aws-vpc-managed)

Are you using this project or any of our other projects? Let us know at [@guardianproject][twitter] or [email us directly][email]


## Related Projects

Check out these related projects.





## Help

File an [issue](https://gitlab.com/guardianproject-ops/terraform-aws-vpc-managed/issues), send us an [email][email] or join us in the Matrix 'verse at [#guardianproject:matrix.org][matrix] or IRC at `#guardianproject` on Freenode.

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://gitlab.com/guardianproject-ops/terraform-aws-vpc-managed/issues) to report any bugs or file feature requests.

### Developing

If you are interested in becoming a contributor, want to get involved in
developing this project, other projects, or want to [join our team][join], we
would love to hear from you! Shoot us an [email][join-email].

In general, PRs are welcome. We follow the typical "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitLab
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Merge Request** so that we can review your changes

**NOTE:** Be sure to merge the latest changes from "upstream" before making a pull request!

## Credits & License 



Copyright © 2021-2021 [The Guardian Project](https://guardianproject.info)

Copyright © 2017-2021 [Cloud Posse, LLC](https://cloudposse.com)






[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.











See [LICENSE.md](LICENSE.md) for full details.

## Trademarks

All other trademarks referenced herein are the property of their respective owners.

## About

**This project is maintained and funded by [The Guardian Project][website].**

[<img src="https://gitlab.com/guardianproject/guardianprojectpublic/-/raw/master/Graphics/GuardianProject/pngs/logo-black-w256.png"/>][website]

We're a [collective of designers and developers][website] focused on useable
privacy and security. Everything we do is 100% FOSS. Check out out other [ops
projects][gitlab] and [non-ops projects][nonops], follow us on
[mastadon][mastadon] or [twitter][twitter], [apply for a job][join], or
[partner with us][partner].







### Contributors

|  [![Abel Luck][abelxluck_avatar]][abelxluck_homepage]<br/>[Abel Luck][abelxluck_homepage] |
|---|

  [abelxluck_homepage]: https://gitlab.com/abelxluck

  [abelxluck_avatar]: https://secure.gravatar.com/avatar/0f605397e0ead93a68e1be26dc26481a?s=100&amp;d=identicon





[logo-square]: https://assets.gitlab-static.net/uploads/-/system/group/avatar/3262938/guardianproject.png?width=88
[logo]: https://guardianproject.info/GP_Logo_with_text.png
[join]: https://guardianproject.info/contact/join/
[website]: https://guardianproject.info
[cdr]: https://digiresilience.org
[cdr-tech]: https://digiresilience.org/tech/
[matrix]: https://riot.im/app/#/room/#guardianproject:matrix.org
[join-email]: mailto:jobs@guardianproject.info
[email]: mailto:support@guardianproject.info
[cdr-email]: mailto:info@digiresilience.org
[twitter]: https://twitter.com/guardianproject
[mastadon]: https://social.librem.one/@guardianproject
[gitlab]: https://gitlab.com/guardianproject-ops
[nonops]: https://gitlab.com/guardianproject
[partner]: https://guardianproject.info/how-you-can-work-with-us/
