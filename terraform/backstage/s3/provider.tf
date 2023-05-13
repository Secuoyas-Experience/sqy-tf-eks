terraform {
  required_providers {
    doppler = {
      source  = "DopplerHQ/doppler"
      version = ">=1.2.2"
    }
  }
}

provider "doppler" {
  doppler_token = var.backstage_doppler_token
}
