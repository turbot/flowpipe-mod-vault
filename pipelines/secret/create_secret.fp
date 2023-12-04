pipeline "create_secret" {
  title       = "Create secret"
  description = "Stores a secret at the specified location."

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
    description = "Specifies the path of the secrets to create/update."
  }

  param "secret" {
    type        = object
    description = "Specifies the secret data to store."
  }

  step "http" "create_secret" {
    method = "post"
    url    = "${param.address}/v1/secret/${param.path}"

    request_headers = {
      "X-Vault-Token" = param.access_token
    }

    request_body = jsonencode(param.secret)
  }
}
