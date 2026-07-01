# 🥗 ShareBite - DevOps & Production Deployment

ShareBite is a food donation platform that connects hotels with NGOs to reduce food waste through real-time food sharing. This repository contains the infrastructure, deployment configuration, and CI/CD pipeline used to deploy ShareBite on AWS.

---

## 📂 Application Repositories

The application source code is maintained in separate repositories:

- 🔧 **Backend** — Spring Boot 3 / Java 21 → [`final-project-backend`](https://github.com/Shreyash-Sutar-04/final-project-backend)
- 🎨 **Frontend** — React + Nginx → [`final-project-frontend`](https://github.com/Shreyash-Sutar-04/final-project-frontend)

---

## ✨ Features

| | |
|---|---|
| 🔁 | Automated CI/CD Pipeline |
| 🐳 | Dockerized Spring Boot Backend |
| 🐳 | Dockerized React Frontend |
| 🌐 | Nginx Production Server |
| ☁️ | AWS RDS Integration |
| 📦 | Docker Compose Deployment |
| 🧹 | Automated Docker Image Management |

---

## 🏗️ Architecture

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

| Category        | Tools |
|------------------|-------|
| ☁️ **Cloud**     | AWS EC2 · AWS RDS · VPC · Security Groups |
| 💻 **Backend**   | Spring Boot 3 · Java 21 · Maven · JWT Authentication |
| 🎨 **Frontend**  | React · Nginx |
| ⚙️ **DevOps**    | Jenkins · Docker · Docker Compose · GitHub · Docker Hub |
| 🗄️ **Database**  | MySQL (AWS RDS) |

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

## 🔄 CI/CD Workflow

> Fully automated via Jenkins — push to deploy.

1. **Push** — Code is pushed to the GitHub repositories.
2. **Clone** — Jenkins automatically clones the frontend and backend repos.
3. **Build** — Backend Docker image is built.
4. **Build** — Frontend Docker image is built.
5. **Publish** — Both images are pushed to Docker Hub.
6. **Pull** — The production server pulls the latest images.
7. **Deploy** — Docker Compose recreates the containers with updated images.
8. **Cleanup** — Old Docker images are removed to free up disk space.

---

## ⚙️ Deployment Steps

### 1️⃣ Launch an EC2 Instance

Launch an Ubuntu Server and open the following inbound ports:

| Port | Purpose |
|------|---------|
| `22` | SSH |
| `80` | HTTP |
| `8080` | Jenkins |

### 2️⃣ Configure the Server

```bash
chmod +x serverSetup.sh
./serverSetup.sh
```

Installs:
- ☕ Java 21
- 🔧 Jenkins
- 🐳 Docker

### 3️⃣ Create an AWS RDS Database

- [ ] Create a MySQL RDS instance
- [ ] Configure the Security Group
- [ ] Allow inbound connections from the EC2 instance
- [ ] Create the application database

### 4️⃣ Configure Jenkins

| Credential ID | Purpose |
|----------------|---------|
| `github-creds` | GitHub authentication |
| `docker-hub-creds` | Docker Hub authentication |

Create a **Pipeline job** pointing to the `Jenkinsfile` in this repository.

### 5️⃣ Configure Environment Variables

Create a `.env` file inside the deployment directory with:

- 🔑 Database Credentials
- 🔐 JWT Secret
- 💳 Stripe Keys
- 📱 Twilio Credentials
- 🤖 Gemini API Key

> ⚠️ **Warning:** Never commit the `.env` file to GitHub.

### 6️⃣ Deploy the Application

Run the Jenkins Pipeline — it automatically:

✅ Clones the repositories
✅ Builds Docker images
✅ Pushes images to Docker Hub
✅ Pulls the latest images on EC2
✅ Deploys via Docker Compose

---

## 🔒 Security

- 🔐 Jenkins Credentials securely store GitHub and Docker Hub credentials
- 🗃️ Application secrets are stored locally in a `.env` file
- 🚫 Sensitive information is never committed to GitHub

---

## 🔮 Future Improvements

- [ ] HTTPS using Nginx and Let's Encrypt
- [ ] AWS ECR for Docker image storage
- [ ] Kubernetes deployment
- [ ] Monitoring with Prometheus and Grafana
- [ ] Centralized logging with ELK Stack

---

## 👨‍💻 Author

**Shreyash Sutar**
*Final Year Engineering Project demonstrating Cloud Computing, DevOps, CI/CD, Docker, Jenkins, and AWS deployment practices.*

---

<p align="center">⭐ If this project helped you, consider giving it a star!</p>
