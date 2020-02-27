terraform {
  backend "gcs" {
    bucket = "storage-buck-tf"
    prefix = "stage"
  }
}
