output "externals_ip_address_app" {
  value = [for app in yandex_compute_instance.app :
            app.network_interface.0.nat_ip_address]
}
