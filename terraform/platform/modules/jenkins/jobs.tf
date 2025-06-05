resource "jenkins_job" "terraform" {
  name        = "terraform-pipeline"
  description = "Terraform Pipeline for Infrastructure"

  scm {
    url      = "https://github.com/AdhamBasheir/random-choices-devops.git"
    branch   = "main"
  }

  definition {
    pipeline {
      script_path = "terraform/Jenkinsfile"
    }
  }

  triggers {
    github_push {}
  }
}

resource "jenkins_job" "frontend" {
  name        = "frontend-pipeline"
  description = "Frontend Pipeline for the Application"

  scm {
    url      = "https://github.com/AdhamBasheir/random-choices-devops.git"
    branch   = "main"
  }

  definition {
    pipeline {
      script_path = "frontend/Jenkinsfile"
    }
  }

  triggers {
    github_push {}
  }
}

resource "jenkins_job" "backend" {
  name        = "backend-pipeline"
  description = "Backend Pipeline for the Application"

  scm {
    url      = "https://github.com/AdhamBasheir/random-choices-devops.git"
    branch   = "main"
  }

  definition {
    pipeline {
      script_path = "backend/Jenkinsfile"
    }
  }
  
  triggers {
    github_push {}
  }
}
