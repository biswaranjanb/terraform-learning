terraform {
  required_version = "< 0.12.0"
}

provider "aws" {
  region = "us-east-1"
}

module "consul" {
  source      = "hashicorp/consul/aws"
  num_servers = 3
  version     = "0.7.3"
}
