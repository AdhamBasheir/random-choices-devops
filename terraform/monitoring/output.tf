output "prometheus_access_info" {
  value = "Run 'kubectl get svc -n monitoring' to get Prometheus EXTERNAL-IP. Login: admin / admin123"
}

output "grafana_access_info" {
  value = "Run 'kubectl get svc -n monitoring' to get Grafana EXTERNAL-IP. Login: admin / admin123"
}

output "alertmanager_access_info" {
  value = "Run 'kubectl get svc -n monitoring' to get Alertmanager EXTERNAL-IP. Login: admin / admin123"
}
