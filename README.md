# Automated Kubernetes Deployment Project

## Overview

This repository demonstrates a complete CI/CD pipeline that automates the deployment of a simple Node.js web application. The entire process, from a code change to a live deployment on a Google Kubernetes Engine (GKE) cluster, is fully automated.

The infrastructure is provisioned using Terraform, the application is containerized with Docker, and the CI/CD workflow is managed by GitHub Actions. The project also incorporates bonus tasks, including security scanning with Trivy and package management with Helm.

---
## Project Demonstration

As requested, the cloud infrastructure used for this project has been de-provisioned to manage costs.

I have recorded a short video to demonstrate the end-to-end workflow in action. The video shows a code change being pushed to GitHub, which automatically triggers the pipeline to build, scan, and deploy the new version to the Kubernetes cluster.

**[Watch the video demonstration here](https://youtu.be/YkP0ZejNyvs)**

---
## Instructions to Run

### Prerequisites

* Google Cloud SDK (`gcloud`)
* Terraform
* Helm
* A configured GCP account with billing enabled.

### Steps

1.  **Provision the Infrastructure:**
    First, navigate to the `terraform` directory and apply the configuration. This will build the GKE cluster and all necessary resources on Google Cloud.

    ```bash
    cd terraform
    terraform apply
    ```

2.  **Create the Kubernetes Secret:**
    Once the cluster is running, create a Kubernetes secret to hold the Docker Hub credentials. This is a one-time manual step that allows the cluster to pull the container image from the private registry.

    ```bash
    kubectl create secret docker-registry docker-creds \
      --docker-server=[https://index.docker.io/v1/](https://index.docker.io/v1/) \
      --docker-username=<your-dockerhub-username> \
      --docker-password=<your-dockerhub-password> \
      --docker-email=<your-email>
    ```

3.  **Automated Deployment:**
    With the infrastructure in place, any `git push` to the `main` branch will automatically trigger the GitHub Actions pipeline to deploy the latest version of the application.

---
## Design Choices

I made several key design choices for this project to align with modern DevOps practices:

* **GKE for Kubernetes:** I chose Google Kubernetes Engine as the managed Kubernetes provider. Using a managed service like GKE offloads the complexity of maintaining the control plane, allowing the team to focus on the application itself.

* **Terraform for IaC:** All cloud infrastructure is defined as code using Terraform. This approach makes the environment fully reproducible, version-controlled, and prevents the "configuration drift" that can occur with manual setups.

* **Multi-Stage Dockerfile:** To keep the final container image small and secure, I used a multi-stage Docker build. The initial stage installs dependencies and builds the application, while the final stage copies only the necessary runtime artifacts, resulting in a lean production image.

* **Helm for Package Management:** Instead of using static YAML files, I packaged the application's Kubernetes manifests into a Helm chart. This is a more robust solution that allows for templating, versioning, and easier management of application releases across different environments.

* **Trivy for Security:** I integrated the Trivy vulnerability scanner directly into the pipeline. This creates an automated security gate that scans every new image for high-severity vulnerabilities before it can be deployed, which is a core principle of shifting security "left" in the development process.
