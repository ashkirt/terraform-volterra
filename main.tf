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

# Create the P12 file using local-exec
resource "null_resource" "create_p12" {
  provisioner "local-exec" {
    command = "echo '${var.VES_API_P12_BASE64}' | base64 -d > ${path.module}/api.p12 && chmod 600 ${path.module}/api.p12"
  }
  
  # Recreate if content changes
  triggers = {
    p12_content = var.VES_API_P12_BASE64
  }
}

# Use the file in provider
provider "volterra" {
  api_p12_file = "${path.module}/api.p12"
  url          = var.VES_tenant_url
}

