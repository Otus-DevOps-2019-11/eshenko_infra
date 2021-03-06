variable project {
  description = "Project ID"
}
variable region {
  description = "Region"
  default     = "europe-north1"
}
variable public_key_path {
  description = "Path to the public key used for ssh access"
}
variable private_key_path {
  description = "Path to the private key used for ssh access"
}
variable zone {
  description = "Zone"
  default     = "europe-north1-b"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-ansible"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "reddit-db-ansible"
}
variable "prov_on" {
  default = false
}
