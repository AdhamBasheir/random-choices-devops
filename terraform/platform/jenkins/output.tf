output "jenkins_service_info" {
  value = "Run 'kubectl get svc -n jenkins' to find the EXTERNAL-IP of Jenkins after apply."
}

output "jenkins_admin_password" {
  value = "Run 'kubectl get secret -n jenkins jenkins-admin -o jsonpath='{.data.jenkins-admin-password}' | base64 --decode' to get the Jenkins admin password."
}
