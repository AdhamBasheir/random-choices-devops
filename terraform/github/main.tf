resource "github_repository" "random_choices_devops" {
  name        = var.repo_name
  private     = false
  visibility  = "public"

  topics = []

  lifecycle {
    ignore_changes = [topics]
  }
}

resource "github_branch" "main" {
  repository = github_repository.random_choices_devops.name
  branch     = var.branch_name
}
