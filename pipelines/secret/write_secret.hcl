pipeline "write_secret" {
  description = "Write secret data to HashiCorp Vault."

  param "address" {
    type        = string
    default     = var.address
    description = "The address of the Vault server."
  }

  param "access_token" {
    type        = string
    default     = var.access_token
    description = "The access token to use for the request."
  }

  param "secret_path" {
    type    = string
    default = "test"
  }

  param "secret_key" {
    type    = object
    default = "password"
  }

  param "secret_value" {
    type    = object
    default = "my-long-password"
  }

  step "http" "write_secret" {
    title  = "Write Vault Secret Data"
    method = "put"
    url    = "${param.address}/v1/secret/data/test"
    request_headers = {
      "X-Vault-Token"   = param.access_token
      "X-Vault-Request" = true
      "Content-Type"    = "application/json"
    }
    request_body = jsonencode({
      data = {
        "${param.secret_key}" = param.secret_value,
      },
      options = {
        cas = 0,
      },
    })
  }

  output "response_body" {
    value = step.http.write_secret.response_body
  }
  output "response_headers" {
    value = step.http.write_secret.response_headers
  }
  output "status_code" {
    value = step.http.write_secret.status_code
  }
}
