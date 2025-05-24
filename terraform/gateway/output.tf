output "contour_version" {
  value = helm_release.contour.version
  description = "Version of the Contour Helm chart deployed"
}
