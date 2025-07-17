terraform {
          required_version = ">= 0.12.9, != 0.13.0"
        
          required_providers {
            volterra = {
              source = "volterraedge/volterra"
              version = ">=0.10.0"
            }
          }
        }

# Variables for base64 encoded content
variable "VES_API_P12_BASE64" {
  description = "Base64 encoded P12 file content"
  type        = string
  sensitive   = true
}

variable "VES_P12_PASSWORD" {
  description = "P12 file password"
  type        = string
  sensitive   = true
}

variable "VES_tenant_url" {
  description = "Tenant URL for Volterra provider"
  type        = string
}

# Create P12 file from base64
resource "local_file" "api_p12" {
  content_base64 = var.VES_API_P12_BASE64
  filename       = "${path.module}/api.p12"
  
  # Ensure proper permissions
  file_permission = "0600"
}

# Use the file in provider
provider "volterra" {
  api_p12_file = local_file.api_p12.filename
  url          = var.VES_tenant_url
}

