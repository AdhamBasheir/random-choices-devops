locals {
  raw_yaml     = file("${path.module}/gateway-api.yaml")
  split_yaml   = split("---", local.raw_yaml)
  decoded_yaml = [for doc in local.split_yaml : yamldecode(trimspace(doc))]
}
