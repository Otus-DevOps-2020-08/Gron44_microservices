enviroment     = "dev"
instance_count = 2

yc_cloud_id  = "b1gfsofllvq4jg8n05kb"
yc_folder_id = "b1ga4qpmadg7vt5lsung"

zone                     = "ru-central1-a"

public_key_path          = "../../secrets/ubuntu.pub"
private_key_path         = "../../secrets/ubuntu"

service_account_key_file = "../../secrets/key.json"

# Module vpc
v4_cidr_blocks           = ["192.168.10.0/24"]

#Module monolith
app_disk_image           = "fd8dluab5nb36vgrl337"

#Ansible inventory
ansible_template = "../../ansible"
