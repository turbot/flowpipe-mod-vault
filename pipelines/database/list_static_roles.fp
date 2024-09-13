pipeline "list_static_roles" {
  title       = "List Static Roles"
  description = "Retrieves a list of available static roles."

  tags = {
    type = "featured"
  }

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "mount_path" {
    type        = string
    description = "Specifies the mount path of the secret backend."
    default     = "database"
  }

  step "http" "list_static_roles" {
    method = "get"
    url    = "${credential.vault[param.cred].address}/v1/${param.mount_path}/static-roles?list=true"

    request_headers = {
      "X-Vault-Token" = credential.vault[param.cred].token
    }
  }

  output "static_roles" {
    description = "The static roles available."
    value       = step.http.list_static_roles.response_body.data.keys
  }
}
