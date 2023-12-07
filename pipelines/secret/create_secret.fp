pipeline "create_secret" {
  title       = "Create secret"
  description = "Stores a secret at the specified location."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
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
    url    = "${credential.vault[param.cred].address}/v1/secret/${param.path}"

    request_headers = {
      "X-Vault-Token" = credential.vault[param.cred].token
    }

    request_body = jsonencode(param.secret)
  }
}
