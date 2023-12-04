pipeline "get_secret" {
  title       = "Get Secret"
  description = "Retrieves the secret at the specified location."

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
    description = "Specifies the path of the secret to read."
  }

  step "http" "get_secret" {
    method = "get"
    url    = "${param.address}/v1/secret/${param.path}"

    request_headers = {
      "X-Vault-Token" = param.access_token
    }
  }

  output "secret" {
    description = "The secret at the specified location."
    value       = step.http.get_secret.response_body.data
  }
}
