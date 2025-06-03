variable "owner" {
    description = "GitHub owner or organization name"
    type        = string
    default     = "AdhamBasheir"
}

variable "github_token" {
  description = "GitHub token with permissions to manage repositories and teams"
  type        = string
}

variable "repo_name" {
    description = "Name of the GitHub repository to create"
    type        = string
    default     = "random-choices-devops"
}

variable "branch_name" {
  description = "Name of the branch to create in the GitHub repository"
  type        = string
  default     = "main"
}
