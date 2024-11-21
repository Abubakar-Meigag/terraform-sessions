provider "aws" {
  region = "eu-west-2"
}

module "ec2module" {
  source  = "./ec2"
  ec2name = "name from Module"
}

output "module_output" {
  value = module.ec2module.instance_id
}