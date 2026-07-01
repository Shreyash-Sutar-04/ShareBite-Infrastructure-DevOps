# 🥗 ShareBite - DevOps & Production Deployment

This repository contains the infrastructure, deployment configuration, and CI/CD pipeline used for deploying the **ShareBite** application on AWS.

ShareBite is a food donation platform that connects hotels with NGOs to reduce food waste by enabling real-time food sharing.

---

## 📂 Application Repositories

The application source code is maintained in separate repositories.

* **Backend (Spring Boot 3 / Java 21)**
  [https://github.com/Shreyash-Sutar-04/final-project-backend](https://github.com/Shreyash-Sutar-04/final-project-backend)

* **Frontend (React + Nginx)**
  [https://github.com/Shreyash-Sutar-04/final-project-frontend](https://github.com/Shreyash-Sutar-04/final-project-frontend)

---

## 🏗️ Architecture

The application is deployed using Docker containers on an AWS EC2 instance.

```text
                        GitHub
                           │
                           │ Push
                           ▼
                    Jenkins Pipeline
                           │
        ┌──────────────────┴──────────────────┐
        │                                     │
        ▼                                     ▼
 Build Backend Image                 Build Frontend Image
        │                                     │
        └──────────────┬──────────────────────┘
                       ▼
              Push Images to Docker Hub
                       │
                       ▼
            Docker Compose Deployment
                       │
                       ▼
              AWS EC2 (Ubuntu Server)
             ┌─────────────────────────┐
             │ Frontend (Nginx)         │
             │ Backend (Spring Boot)    │
             └─────────────────────────┘
                       │
                       ▼
                AWS RDS (MySQL)
```

---

## 🚀 Tech Stack

### ☁️ Cloud

* AWS EC2
* AWS RDS
* VPC
* Security Groups

### 💻 Backend

* Spring Boot 3
* Java 21
* Maven
* JWT Authentication

### 🎨 Frontend

* React
* Nginx

### ⚙️ DevOps

* Jenkins
* Docker
* Docker Compose
* GitHub
* Docker Hub

### 🗄️ Database

* MySQL (AWS RDS)

---

## 🔄 CI/CD Workflow

The deployment process is automated using Jenkins.

1. Code is pushed to the GitHub repositories.
2. Jenkins automatically clones the frontend and backend repositories.
3. The backend Docker image is built.
4. The frontend Docker image is built.
5. Both Docker images are pushed to Docker Hub.
6. The production server pulls the latest images.
7. Docker Compose recreates the containers with the updated images.
8. Old Docker images are removed to free up disk space.

---

## 📁 Project Structure

```text
.
├── Jenkinsfile
├── docker-compose.yml
├── serverSetup.sh
├── README.md
└── screenshots/
```

---

## ⚙️ Deployment Steps

### 1. Launch an EC2 Instance

Launch an Ubuntu Server and allow the following inbound ports:

* 22 (SSH)
* 80 (HTTP)
* 8080 (Jenkins)

---

### 2. Configure the Server

Run the setup script.

```bash
chmod +x serverSetup.sh
./serverSetup.sh
```

The script installs:

* Java 21
* Jenkins
* Docker

---

### 3. Create an AWS RDS Database

* Create a MySQL RDS instance.
* Configure the Security Group.
* Allow inbound connections from the EC2 instance.
* Create the application database.

---

### 4. Configure Jenkins

Create the following Jenkins credentials.

| Credential ID    | Purpose                   |
| ---------------- | ------------------------- |
| github-creds     | GitHub authentication     |
| docker-hub-creds | Docker Hub authentication |

Create a Pipeline job and configure it to use the `Jenkinsfile` from this repository.

---

### 5. Configure Environment Variables

Create a `.env` file inside the deployment directory and add the required application secrets.

Example:

* Database Credentials
* JWT Secret
* Stripe Keys
* Twilio Credentials
* Gemini API Key

**Note:** Never commit the `.env` file to GitHub.

---

### 6. Deploy the Application

Run the Jenkins Pipeline.

The pipeline automatically:

* Clones the repositories
* Builds Docker images
* Pushes images to Docker Hub
* Pulls the latest images on EC2
* Deploys the application using Docker Compose

---

## 🔒 Security

* Jenkins Credentials are used to securely store GitHub and Docker Hub credentials.
* Application secrets are stored locally in a `.env` file.
* Sensitive information is never committed to GitHub.

---

## ✨ Features

* Automated CI/CD Pipeline
* Dockerized Spring Boot Backend
* Dockerized React Frontend
* Nginx Production Server
* AWS RDS Integration
* Docker Compose Deployment
* Automated Docker Image Management

---

## 🔮 Future Improvements

* HTTPS using Nginx and Let's Encrypt
* AWS ECR for Docker image storage
* Kubernetes deployment
* Monitoring with Prometheus and Grafana
* Centralized logging with ELK Stack

---

## 👨‍💻 Author

**Shreyash Sutar**

Final Year Engineering Project demonstrating Cloud Computing, DevOps, CI/CD, Docker, Jenkins, and AWS deployment practices.
