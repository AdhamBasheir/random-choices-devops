resource "github_repository_webhook" "argocd_webhook" {
  repository = var.repo_name

  configuration {
    url          = ""
    content_type = "json"
    insecure_ssl = true
  }

  events = ["push"]
  active = true

  depends_on = [github_repository.random_choices_devops]
}

resource "github_repository_webhook" "terraform_webhook" {
  repository = var.repo_name

  configuration {
    url          = ""
    content_type = "json"
    insecure_ssl = true
  }

  events = ["push"]
  active = true

  depends_on = [module.jenkins]
}

resource "github_repository_webhook" "jenkins_webhook" {
  repository = var.repo_name

  configuration {
    url          = ""
    content_type = "json"
    insecure_ssl = true
  }

  events = ["push"]
  active = true

  depends_on = [module.jenkins]
}
