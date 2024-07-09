output "rg_name" {
  value = module.default_label.id
}

output "aca_name" {
  value = module.aca.container_app_name
}

output "aca_id" {
  value = module.aca.container_app_id
}

output "aca_fqdn" {
  value = module.aca.container_app_fqdn
}
