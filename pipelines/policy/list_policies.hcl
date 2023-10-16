pipeline "list_policies" {
  description = "Read secret data from HashiCorp Vault."

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

  step "http" "list_policies" {
    title  = "Read Vault Secret Data"
    method = "get"
    url    = "${param.address}/v1/sys/policy"
    request_headers = {
      "X-Vault-Token" = param.access_token
    }
  }

  output "secret_data" {
    value = jsondecode(step.http.list_policies.response_body)
  }
  output "response_headers" {
    value = step.http.list_policies.response_headers
  }
  output "status_code" {
    value = step.http.list_policies.status_code
  }
}
