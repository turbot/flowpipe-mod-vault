pipeline "get_static_creds" {
  title       = "Get Static Creds"
  description = "Retrieves current credentials based on the named static role."

  tags = {
    type = "featured"
  }

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "name" {
    type        = string
    description = "Specifies the name of the static role to get credentials for."
  }

  param "mount_path" {
    type        = string
    description = "Specifies the mount path of the secret backend."
    default     = "database"
  }

  step "http" "get_static_creds" {
    method = "get"
    url    = "${credential.vault[param.cred].address}/v1/${param.mount_path}/static-creds/${param.name}"

    request_headers = {
      "X-Vault-Token" = credential.vault[param.cred].token
    }
  }

  output "static_creds" {
    description = "The current credentials based on the named static role."
    value       = step.http.get_static_creds.response_body.data
  }
}
