output "private_app_ids" {
  description = "Map of private app IDs keyed by private app name"
  value       = { for name, app in cato_private_app.this : name => app.id }
}
