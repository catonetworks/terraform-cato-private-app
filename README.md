# Cato Networks GCP Private App Terraform Module

This module creates `cato_private_app` resources from a JSON file.

## Dependencies
A published private application refers to an app-connector group (connector_group_name) that must already exist.
See https://registry.terraform.io/modules/catonetworks/appconnector-gcp/cato module for more information about app-connectors on GCP (similar for -aws and -azure).

## Usage

```hcl
module "private_apps" {
  # depends_on             = [module.app_connector_gcp]
  source                 = "catonetworks/private-app-gcp/cato"
  private_apps_json_file = "${path.module}/data/private-apps.json"
}


output "private_app_ids" {
  description = "Map of private app IDs keyed by private app name"
  value       = module.private_apps.private_app_ids
}
```

## Input JSON format

The input file must contain a JSON array, where each item maps to one private app.

```json
[
  {
    "name": "private-app-example",
    "description": "private-app-example description",
    "internal_app_address": "172.198.30.10",
    "protocol_ports": [
      { "ports": [80], "protocol": "TCP" },
      { "ports": [443], "protocol": "TCP" },
      { "port_range": { "from": 6000, "to": 6010 }, "protocol": "TCP" }
    ],
    "allow_icmp_protocol": true,
    "probing_enabled": true,
    "private_app_probing": {
      "type": "ICMP_PING",
      "interval": 5,
      "fault_threshold_down": 10
    },
    "published": true,
    "published_app_domain": {
      "connector_group_name": "site1",
      "published_app_domain": "private-app-example.example.com"
    }
  }
]
```


<!-- BEGIN_TF_DOCS -->

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cato"></a> [cato](#provider\_cato) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cato_private_app.this](https://registry.terraform.io/providers/catonetworks/cato/latest/docs/resources/private_app) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_private_apps_json_file"></a> [private\_apps\_json\_file](#input\_private\_apps\_json\_file) | Path to a JSON file containing an array of private app definitions | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_app_ids"></a> [private\_app\_ids](#output\_private\_app\_ids) | Map of private app IDs keyed by private app name |
