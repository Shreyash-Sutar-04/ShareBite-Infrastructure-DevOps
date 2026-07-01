pipeline {
    agent any

    environment {
        // Docker Hub username
        DOCKER_USER = "shreyashsutar124"

        // EC2 Public IP
        EC2_PUBLIC_IP = "52.66.200.211"
    }

    stages {

        stage('Clone Repos') {
            steps {
                cleanWs()

                dir('backend') {
                    git branch: 'main',
                        credentialsId: 'github-creds',
                        url: 'https://github.com/Shreyash-Sutar-04/final-project-backend.git'
                }

                dir('frontend') {
                    git branch: 'main',
                        credentialsId: 'github-creds',
                        url: 'https://github.com/Shreyash-Sutar-04/final-project-frontend.git'
                }
            }
        }

        stage('Build & Push Backend') {
            steps {
                dir('backend') {
                    script {
                        docker.withRegistry('', 'docker-hub-creds') {
                            def backendImg = docker.build("${DOCKER_USER}/final-backend:latest")
                            backendImg.push()
                        }
                    }
                }
            }
        }

        stage('Build & Push Frontend') {
            steps {
                dir('frontend') {
                    script {
                        docker.withRegistry('', 'docker-hub-creds') {
                            // Pass React environment variables during Docker build
                            // The "." at the end specifies the current directory as the build context.
                            def frontendImg = docker.build(
                                "${DOCKER_USER}/final-frontend:latest",
                                "--build-arg REACT_APP_API_URL=http://${EC2_PUBLIC_IP}:8081/api " +
                                "--build-arg REACT_APP_WS_URL=http://${EC2_PUBLIC_IP}:8081/ws ."
                            )

                            frontendImg.push()
                        }
                    }
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sh '''
                export DOCKER_USER=${DOCKER_USER}

                # Go to deployment directory
                cd /var/lib/jenkins/deploy

                # Pull latest Docker images
                docker compose pull

                # Recreate containers
                docker compose up -d --remove-orphans

                # Remove unused Docker images
                docker image prune -f
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed. Check the console output for details.'
        }

        always {
            cleanWs()
        }
    }
}
