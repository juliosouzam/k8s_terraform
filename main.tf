terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.provider_token
}

resource "digitalocean_kubernetes_cluster" "k8s_cluster" {
  name         = "k8s-${terraform.workspace}"
  region       = var.k8s_region
  version      = var.k8s_version
  auto_upgrade = false
  ha           = false

  node_pool {
    name       = "default"
    size       = var.k8s_node_size
    node_count = var.k8s_node_count
  }
}

variable "provider_token" {
  type        = string
  description = "Token da Digital Ocean"
}

variable "k8s_region" {
  type    = string
  default = "nyc3"
}

variable "k8s_version" {
  type    = string
  default = "1.29.1-do.0"
}

variable "k8s_node_size" {
  type    = string
  default = "s-2vcpu-2gb"
}

variable "k8s_node_count" {
  type    = number
  default = 3
}
