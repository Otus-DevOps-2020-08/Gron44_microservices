variable "instance_count" {
    type = number
    description = "monolithic apps instance count"
}
variable public_key_path {
  type = string
  description = "Path to the public key used for ssh access"
}
variable app_disk_image {
  type = string
  description = "Disk image for reddit app"
  default = "reddit-app-base"
}
variable subnet_id {
  type = string
  description = "Subnets for modules"
}
variable private_key_path {
  type = string
  description = "Path to the private key used for ssh access"
}
