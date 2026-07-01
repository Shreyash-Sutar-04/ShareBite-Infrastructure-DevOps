<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>ShareBite - DevOps & Production Deployment</title>
<style>
  body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; max-width: 900px; margin: 40px auto; padding: 0 20px; line-height: 1.6; color: #24292f; }
  h1, h2, h3 { border-bottom: 1px solid #d0d7de; padding-bottom: .3em; }
  code, pre { background: #f6f8fa; border-radius: 6px; }
  code { padding: 2px 6px; font-family: "SFMono-Regular", Consolas, monospace; }
  pre { padding: 16px; overflow-x: auto; }
  pre code { padding: 0; background: none; }
  table { border-collapse: collapse; width: 100%; margin: 1em 0; }
  th, td { border: 1px solid #d0d7de; padding: 8px 12px; text-align: left; }
  th { background: #f6f8fa; }
  blockquote { border-left: 4px solid #d0d7de; margin: 1em 0; padding: 0 1em; color: #57606a; }
  a { color: #0969da; text-decoration: none; }
  a:hover { text-decoration: underline; }
  hr { border: none; border-top: 1px solid #d0d7de; margin: 2em 0; }
</style>
</head>
<body>

<h1>🥗 ShareBite - DevOps & Production Deployment</h1>
<p>ShareBite is a food donation platform that connects hotels with NGOs to reduce food waste through real-time food sharing. This repository contains the infrastructure, deployment configuration, and CI/CD pipeline used to deploy ShareBite on AWS.</p>

<hr>

<h2>📂 Application Repositories</h2>
<p>The application source code is maintained in separate repositories:</p>
<ul>
  <li><strong>Backend</strong> (Spring Boot 3 / Java 21) → <a href="https://github.com/Shreyash-Sutar-04/final-project-backend">final-project-backend</a></li>
  <li><strong>Frontend</strong> (React + Nginx) → <a href="https://github.com/Shreyash-Sutar-04/final-project-frontend">final-project-frontend</a></li>
</ul>

<hr>

<h2>✨ Features</h2>
<ul>
  <li>Automated CI/CD Pipeline</li>
  <li>Dockerized Spring Boot Backend</li>
  <li>Dockerized React Frontend</li>
  <li>Nginx Production Server</li>
  <li>AWS RDS Integration</li>
  <li>Docker Compose Deployment</li>
  <li>Automated Docker Image Management</li>
</ul>

<hr>

<h2>🏗️ Architecture</h2>
<pre><code>                        GitHub
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
</code></pre>

<hr>

<h2>🚀 Tech Stack</h2>
<table>
  <tr><th>Category</th><th>Tools</th></tr>
  <tr><td>☁️ Cloud</td><td>AWS EC2, AWS RDS, VPC, Security Groups</td></tr>
  <tr><td>💻 Backend</td><td>Spring Boot 3, Java 21, Maven, JWT Authentication</td></tr>
  <tr><td>🎨 Frontend</td><td>React, Nginx</td></tr>
  <tr><td>⚙️ DevOps</td><td>Jenkins, Docker, Docker Compose, GitHub, Docker Hub</td></tr>
  <tr><td>🗄️ Database</td><td>MySQL (AWS RDS)</td></tr>
</table>

<hr>

<h2>📁 Project Structure</h2>
<pre><code>.
├── Jenkinsfile
├── docker-compose.yml
├── serverSetup.sh
├── README.md
└── screenshots/
</code></pre>

<hr>

<h2>🔄 CI/CD Workflow</h2>
<ol>
  <li>Code is pushed to the GitHub repositories.</li>
  <li>Jenkins automatically clones the frontend and backend repositories.</li>
  <li>The backend Docker image is built.</li>
  <li>The frontend Docker image is built.</li>
  <li>Both Docker images are pushed to Docker Hub.</li>
  <li>The production server pulls the latest images.</li>
  <li>Docker Compose recreates the containers with the updated images.</li>
  <li>Old Docker images are removed to free up disk space.</li>
</ol>

<hr>

<h2>⚙️ Installation / Deployment Steps</h2>

<h3>1. Launch an EC2 Instance</h3>
<p>Launch an Ubuntu Server and allow the following inbound ports:</p>
<ul>
  <li><code>22</code> (SSH)</li>
  <li><code>80</code> (HTTP)</li>
  <li><code>8080</code> (Jenkins)</li>
</ul>

<h3>2. Configure the Server</h3>
<pre><code>chmod +x serverSetup.sh
./serverSetup.sh</code></pre>
<p>The script installs:</p>
<ul>
  <li>Java 21</li>
  <li>Jenkins</li>
  <li>Docker</li>
</ul>

<h3>3. Create an AWS RDS Database</h3>
<ul>
  <li>Create a MySQL RDS instance.</li>
  <li>Configure the Security Group.</li>
  <li>Allow inbound connections from the EC2 instance.</li>
  <li>Create the application database.</li>
</ul>

<h3>4. Configure Jenkins</h3>
<table>
  <tr><th>Credential ID</th><th>Purpose</th></tr>
  <tr><td><code>github-creds</code></td><td>GitHub authentication</td></tr>
  <tr><td><code>docker-hub-creds</code></td><td>Docker Hub authentication</td></tr>
</table>
<p>Create a Pipeline job and configure it to use the <code>Jenkinsfile</code> from this repository.</p>

<h3>5. Configure Environment Variables</h3>
<p>Create a <code>.env</code> file inside the deployment directory and add the required application secrets, e.g.:</p>
<ul>
  <li>Database Credentials</li>
  <li>JWT Secret</li>
  <li>Stripe Keys</li>
  <li>Twilio Credentials</li>
  <li>Gemini API Key</li>
</ul>
<blockquote>⚠️ <strong>Never commit the <code>.env</code> file to GitHub.</strong></blockquote>

<h3>6. Deploy the Application</h3>
<p>Run the Jenkins Pipeline. It automatically:</p>
<ul>
  <li>Clones the repositories</li>
  <li>Builds Docker images</li>
  <li>Pushes images to Docker Hub</li>
  <li>Pulls the latest images on EC2</li>
  <li>Deploys the application using Docker Compose</li>
</ul>

<hr>

<h2>🔒 Security</h2>
<ul>
  <li>Jenkins Credentials securely store GitHub and Docker Hub credentials.</li>
  <li>Application secrets are stored locally in a <code>.env</code> file.</li>
  <li>Sensitive information is never committed to GitHub.</li>
</ul>

<hr>

<h2>🔮 Future Improvements</h2>
<ul>
  <li>HTTPS using Nginx and Let's Encrypt</li>
  <li>AWS ECR for Docker image storage</li>
  <li>Kubernetes deployment</li>
  <li>Monitoring with Prometheus and Grafana</li>
  <li>Centralized logging with ELK Stack</li>
</ul>

<hr>

<h2>👨‍💻 Author</h2>
<p><strong>Shreyash Sutar</strong><br>
Final Year Engineering Project demonstrating Cloud Computing, DevOps, CI/CD, Docker, Jenkins, and AWS deployment practices.</p>

<hr>

<h2>📄 License</h2>
<p>MIT — see <a href="LICENSE">LICENSE</a> file for details.</p>

</body>
</html>
