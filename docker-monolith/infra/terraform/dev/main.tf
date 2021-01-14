provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = var.zone
}

terraform {
  backend "s3" {
    endpoint    = "storage.yandexcloud.net"
    key         = "terraform/terraform.tfstate"
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}


module "vpc" {
  source         = "../modules/vpc"
  zone           = var.zone
  v4_cidr_blocks = var.v4_cidr_blocks
}


module "monolith" {
  source           = "../modules/monolith"
  instance_count   = var.instance_count
  public_key_path  = var.public_key_path
  private_key_path = var.private_key_path
  app_disk_image   = var.app_disk_image
  subnet_id        = module.vpc.external_vpc_id
}

#Ansible inventory
locals {
  dev_hosts = <<EOT
[monolith]
%{ for ip in module.monolith.externals_ip_address_app }
${ip}
%{ endfor }
EOT
}

resource "local_file" "dev_hosts" {
  filename = "${var.ansible_template}/dev_hosts"
  content  = local.dev_hosts
}
