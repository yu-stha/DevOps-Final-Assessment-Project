terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "app" {
  name = "devsecops-net"
}

resource "docker_image" "site" {
  name         = "ghcr.io/yu-stha/devops-final-assessment-project:15260b7"
  keep_locally = true
}

resource "docker_container" "site" {
  name    = "site-terraform"
  image   = docker_image.site.image_id
  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.app.name
  }

  ports {
    internal = 8080
    external = 8090
  }
}

output "url" {
  value = "http://127.0.0.1:8090"
}
