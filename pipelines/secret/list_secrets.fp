pipeline "list_secrets" {
  title       = "List Secrets"
  description = "Returns a list of key names at the specified location."

  param "address" {
    type        = string
    description = local.address_param_description
    default     = var.address
  }

  param "access_token" {
    type        = string
    description = local.access_token_param_description
    default     = var.access_token
  }

  param "path" {
    type        = string
    description = "Specifies the path of the secrets to list."
    optional    = true
  }

  step "http" "list_secrets" {
    method = "get"
    url    = "${param.address}/v1/secret/${param.path != null ? param.path : ""}?list=true"

    request_headers = {
      "X-Vault-Token" = param.access_token
    }
  }

  output "keys" {
    description = "The list of key names at the specified location."
    value       = step.http.list_secrets.response_body.data.keys
  }
}
