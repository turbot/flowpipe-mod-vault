pipeline "list_secrets" {
  title       = "List Secrets"
  description = "Returns a list of key names at the specified location."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "path" {
    type        = string
    description = "Specifies the path of the secrets to list."
    optional    = true
  }

  step "http" "list_secrets" {
    method = "get"
    url    = "${credential.vault[param.cred].address}/v1/secret/${param.path != null ? param.path : ""}?list=true"

    request_headers = {
      "X-Vault-Token" = credential.vault[param.cred].token
    }
  }

  output "keys" {
    description = "The list of key names at the specified location."
    value       = step.http.list_secrets.response_body.data.keys
  }
}
