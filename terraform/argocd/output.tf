output "argocd_admin_password" {
  value = "Run: kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath='{.data.password}' | base64 --decode; echo"
}