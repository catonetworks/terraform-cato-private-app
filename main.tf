locals {
  private_apps = {
    for app in jsondecode(file(var.private_apps_json_file)) : app.name => app
  }
}

resource "cato_private_app" "this" {
  for_each = local.private_apps

  name                 = each.value.name
  description          = try(each.value.description, null)
  internal_app_address = try(each.value.internal_app_address, null)
  protocol_ports       = try(each.value.protocol_ports, null)
  allow_icmp_protocol  = try(each.value.allow_icmp_protocol, null)
  probing_enabled      = try(each.value.probing_enabled, null)
  private_app_probing  = try(each.value.private_app_probing, null)
  published            = try(each.value.published, null)
  published_app_domain = try(each.value.published_app_domain, null)
}
