//==========================================================================
//Definition of the Origin
//Start of the TF file
resource "volterra_origin_pool" "asingla-test-pool" {
  name                   = "asingla-test-pool"
  //Name of the namespace where the origin pool must be deployed
  namespace              = "asingla"
  origin_servers {

    public_ip {
      ip = "54.152.165.236"
    }

    labels = {
    }
  }

  no_tls = true
  port = 80
  endpoint_selection     = "LOCALPREFERED"
  loadbalancer_algorithm = "LB_OVERRIDE"
}
//End of the file
//==========================================================================

//Definition of the WAAP Policy
resource "volterra_app_firewall" "asingla-waap-new" {
  name      = "asingla-waap-new"
  namespace = "asingla"

  // One of the arguments from this list "allow_all_response_codes allowed_response_codes" must be set
  allow_all_response_codes = true
  // One of the arguments from this list "default_anonymization custom_anonymization disable_anonymization" must be set
  default_anonymization = true
  // One of the arguments from this list "use_default_blocking_page blocking_page" must be set
  use_default_blocking_page = true
  // One of the arguments from this list "default_bot_setting bot_protection_setting" must be set
  // One of the arguments from this list "default_detection_settings detection_settings" must be set
  default_detection_settings = true
  // One of the arguments from this list "use_loadbalancer_setting blocking monitoring" must be set
  // Blocking mode - optional - if not set, policy is in MONITORING
  blocking = true
}

//End of the file
//==========================================================================
