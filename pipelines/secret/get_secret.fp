pipeline "get_secret" {
  title       = "Get Secret"
  description = "Retrieves the secret at the specified location."

  tags = {
    type = "featured"
  }

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "path" {
    type        = string
    description = "Specifies the path of the secret to read."
  }

  step "http" "get_secret" {
    method = "get"
    url    = "${credential.vault[param.cred].address}/v1/secret/${param.path}"

    request_headers = {
      "X-Vault-Token" = credential.vault[param.cred].token
    }
  }

  output "secret" {
    description = "The secret at the specified location."
    value       = step.http.get_secret.response_body.data
  }
}
