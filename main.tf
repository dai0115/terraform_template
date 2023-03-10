terraform {
  required_version = "1.3.5"
}

provider "aws" {
  region = "ap-northeast-1"
}

module "s3" {
  source = "./modules/s3"
}

module "network" {
  source     = "./modules/network"
  alb_bucket = module.s3.alb_log_id
  dns_name   = var.dns_name
}

module "compting" {
  source              = "./modules/computing"
  private_subnet_0_id = module.network.private_subnet_0_id
  private_subnet_1_id = module.network.private_subnet_1_id
  target_group_arn    = module.network.target_group_arn
  cidr_block          = module.network.cidr_block
  vpc_id              = module.network.vpc_id
}

module "encryption" {
  source              = "./modules/encryption"
  operation_bucket_id = module.s3.operation_bucket_id
  operation_log_name  = module.compting.operation_log_name
}

module "db" {
  source              = "./modules/db"
  private_subnet_0_id = module.network.private_subnet_0_id
  private_subnet_1_id = module.network.private_subnet_1_id
  kms_key_arn         = module.encryption.kms_key_arn
  cidr_block          = module.network.cidr_block
  vpc_id              = module.network.vpc_id
}

module "cicd" {
  source             = "./modules/cicd"
  ecs_cluster_name   = module.compting.ecs_cluster_name
  ecs_service_name   = module.compting.ecs_service_name
  artifact_bucket_id = module.s3.artifact_bucket_id
}

output "domain_name" {
  value = module.network.domain_name
}