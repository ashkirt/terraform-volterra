variable "VES_tenant_url" {
  description = "Tenant URL for Volterra provider"
  type        = string
}
variable "VES_p12_certificate_content" {
  description = "Base64 encoded content of the .p12 certificate file."
  type        = string
  sensitive   = true
}
