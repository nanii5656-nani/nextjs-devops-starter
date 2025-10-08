
## Project Title

Containerize and Deploy a Next.js Application using Docker, GitHub Actions, and Minikube

---

## 1️⃣ Project Overview

This project demonstrates the following:

- Containerizing a Next.js application using Docker with production-ready best practices.
- Automating Docker image build and push to GitHub Container Registry (GHCR) via GitHub Actions.
- Deploying the containerized app to Kubernetes (Minikube) using manifests.
- Implementing health checks and replicas for production-grade deployment.

---

## 2️⃣ Prerequisites

Make sure you have the following installed:

- Node.js v18+
- Docker
- kubectl
- Minikube
- Git

---

## 3️⃣ Local Setup and Run

Clone the repository:

```bash
git clone https://github.com/nanii5656-nani/nextjs-devops-starter.git
cd nextjs-devops-starter

---
#Install dependencies:

npm ci
npm run dev
npm run build
npm start

Your app will run on http://localhost:3000

-------------
#Docker
docker build -t nextjs-devops-starter:latest .
docker run -p 3000:3000 nextjs-devops-starter:latest


---

***  GitHub Actions (CI/CD) ***

Workflow path: .github/workflows/ci.yml

On every push to master, GitHub Actions will:

Build the Docker image.

Tag the image with latest and the commit SHA.

Push the image to GitHub Container Registry (GHCR).

*** GHCR Image URL: ****
https://github.com/nanii5656-nani/nextjs-devops-starter/pkgs/container/nextjs-devops-starter

----

**** Kubernetes Deployment ***

Manifests Folder

All Kubernetes manifests are in the k8s/ folder:

deployment.yaml – defines Deployment with 2 replicas, liveness/readiness probes.

service.yaml – exposes the app via NodePort service.

###  Deploy to Minikube :--

**** minikube start ***
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
kubectl rollout restart deployment my-nextjs-app
kubectl get pods -w
minikube service my-nextjs-app-service

