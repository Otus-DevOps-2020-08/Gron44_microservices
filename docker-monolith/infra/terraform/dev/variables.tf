variable enviroment {
    type = string
    description = "Current enviroment"
    default = "dev"
}
variable "instance_count" {
    type = number
    description = "monolithic apps instance count"
    default = 1
}


variable yc_cloud_id  {
    type = string
    description = "YC cloud ID"
}
variable yc_folder_id {
    type = string
    description = "YC folder ID"
}

variable zone {
    type = string
    description = "YC zone"
    default = "ru-central1-a"

}



variable public_key_path {
    type = string
    description = "SSH public key"
}
variable private_key_path {
    type = string
    description = "SSH private key"
}

variable service_account_key_file {
    type = string
    description = "YC service account key file"
}

# # Module state
# variable yc_bucket {
#     type = string
#     description = "YC S3 bucket name"
# }
# variable yc_region {
#     type = string
#     description = "YC S3 region"
# }
# variable yc_state_key {
#     type = string
#     description = "YC path to state file in S3 bucket"
# }
# variable yc_access_key {
#     type = string
#     description = "YC S3 access key"
# }
# variable yc_secret_key {
#     type = string
#     description = "YC S3 secret key"
# }
# variable "yc_SA_id" {
#     type = string
#     description = "YC service account id for S3 access/control"
# }

# Module vpc
variable v4_cidr_blocks {
    description = "YC list of blocks of internal IPv4 addresses that are owned by this subnet"
}

# Module monolith
variable app_disk_image {
    type = string
    description = "YC docker cooked image"
}
# variable docker_image {
#     type = string
#   description = "Docker image"
# }

#Ansible inventory
variable "ansible_template" {
    type = string
    description = "Path to ansible inventory folder"
}
