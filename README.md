# 🎲 Random Name Picker - Full Stack App

A full stack application that lets users input a list of names and a number. The backend randomly picks names the specified number of times, groups and sorts them, and sends the results back to be displayed on the frontend.


## 🌐 Live Deployment

This app is deployed on **Google Kubernetes Engine (GKE)** with infrastructure managed using **Terraform Cloud**, automated deployments via **ArgoCD**, and observability powered by **Prometheus** and **Grafana**.


## 🧩 Tech Stack

### Frontend
- **HTML, CSS, JavaScript**
- Validates input:
  - At least one name required
  - Number must be a positive integer

### Backend
- **Go (Golang)**
- Accepts validated input
- Randomly picks names the given number of times
- Groups and sorts picked names
  - First by number of times picked
  - Then alphabetically if tied
- Returns results as JSON to the frontend

### DevOps & Infrastructure
- **Google Kubernetes Engine (GKE)**
- **ArgoCD** for GitOps-based CI/CD
- **Prometheus & Grafana** for monitoring and visualization
- **Terraform Cloud** as a remote backend for infrastructure state
- **Gateway API** used for ingress and routing
- **CLI Tool**: [terraform-batch](https://github.com/AdhamBasheir/terraform-batch.git) for easier multi-directory Terraform management


## 📁 Terraform Directory Structure
```
terraform/
├── infra/ # GKE cluster, VPC, Terraform backend, etc.
│ └── main.tf
├── platform/ # Helm charts, ArgoCD, monitoring stack, etc.
│ └── main.tf
└── manifests/ # Application Kubernetes manifests
└── main.tf
```

## 🚀 Getting Started

### 1. Manual Terraform Deployment

Apply the directories **in order**:

```bash
cd terraform/infra && terraform init && terraform apply
cd ../platform && terraform init && terraform apply
cd ../manifests && terraform init && terraform apply
```

### 2. Use Terraform Cloud Triggers
You can apply only infra and allow Terraform Cloud to trigger the rest of the stages automatically based on workspace dependencies.

### 3. Use the CLI Tool
You can simplify the whole process using the [terraform-batch CLI tool](https://github.com/AdhamBasheir/terraform-batch.git).
```bash
terraform-batch apply infra platform manifests
```

## 📊 Monitoring
Once deployed:

- Access Grafana via the Load Balancer endpoint
- Use default dashboards or import custom ones for application metrics
- Prometheus automatically scrapes metrics from instrumented services

## 🔧 Development & Contribution
Contributions are welcome! Please fork the repo, open issues, or submit pull requests.

For local development:
- Frontend runs on a static server or live server
- Backend can be tested with Go’s built-in tools and mocked data
- Kubernetes manifests and Terraform plans can be tested using kind and terraform plan

🙌 Acknowledgements
Thanks to the open source community and the developers behind:
- Terraform
- ArgoCD
- Prometheus & Grafana
- Kubernetes Gateway API
