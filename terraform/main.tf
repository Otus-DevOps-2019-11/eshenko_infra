terraform {
  required_version = "0.12.19"
}

provider "google" {
  version = "2.15"
  project = var.project
  region  = var.region
}

resource "google_compute_instance" "app" {
  name         = "reddit-app-tf"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["reddit-app-tf"]
  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }
  #  metadata = {
  #    ssh-keys = "appuser:${file(var.public_key_path)}\nappuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}\nappuser3:${file(var.public_key_path)}"
  #  }
  network_interface {
    network = "default"
    access_config {}
  }
  connection {
    type        = "ssh"
    host        = self.network_interface[0].access_config[0].nat_ip
    user        = "appuser"
    agent       = false
    private_key = file(var.private_key_path)
  }
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}appuser3:${file(var.public_key_path)}"
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app-tf"]
}
