variable "VES_tenant_url" {
  description = "Tenant URL for Volterra provider"
  type        = string
}
variable "VES_P12_CONTENT" {
  description = "Base64 encoded content of the .p12 certificate file."
  type        = string
  sensitive   = true
}
variable "VES_P12_PASSWORD" {
  description = "password"
  type        = string
  sensitive   = true
}
