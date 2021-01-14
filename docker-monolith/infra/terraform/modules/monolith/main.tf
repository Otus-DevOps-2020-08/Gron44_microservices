resource "yandex_compute_instance" "app" {
  count = var.instance_count
  name  = "reddit-app-${count.index}"

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id =  var.subnet_id
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }
}


/*
provider "docker" {
  host = "ssh://ubuntu@${yandex_compute_instance.app.network_interface.0.nat_ip_address}:22"
}

resource "docker_image" "app" {
  name = var.docker_image_app
}

# Start a container
# docker run --name reddit -d -p 9292:9292 popadec/otus-reddit:1.0
resource "docker_container" "app" {
  name  = "reddit_app"
  image = docker_image.app.latest
  ports {
    internal = 9292
    external = 9292
    ip       = "0.0.0.0"
    protocol = "tcp"
  }

}
*/
