pipeline "list_policies" {
  title       = "List Policies"
  description = "Lists all configured policies."

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

  step "http" "list_policies" {
    method = "get"
    url    = "${param.address}/v1/sys/policy"

    request_headers = {
      "X-Vault-Token" = param.access_token
    }
  }

  output "policies" {
    description = "The list of configured policies."
    value       = step.http.list_policies.response_body.policies
  }
}
