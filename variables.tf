variable "private_apps_json_file" {
  description = "Path to a JSON file containing an array of private app definitions"
  type        = string

  validation {
    condition     = fileexists(var.private_apps_json_file)
    error_message = "The private_apps_json_file path must point to an existing file."
  }

  validation {
    condition     = can(jsondecode(file(var.private_apps_json_file)))
    error_message = "The private_apps_json_file content must be valid JSON."
  }

  validation {
    condition     = can([for app in jsondecode(file(var.private_apps_json_file)) : app.name])
    error_message = "The private_apps_json_file content must be a JSON array of objects that include a 'name' field."
  }

  validation {
    condition     = length(distinct([for app in jsondecode(file(var.private_apps_json_file)) : app.name])) == length([for app in jsondecode(file(var.private_apps_json_file)) : app.name])
    error_message = "Each private app in private_apps_json_file must have a unique 'name'."
  }
}
