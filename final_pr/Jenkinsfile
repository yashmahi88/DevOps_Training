pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'docker-cred' // ID of the Docker Hub credentials in Jenkins
    }
    stages {
        stage('Checkout') {
            steps {
                // Replace 'main' with your branch name if it's different
                git url: 'https://github.com/yashmahi88/new_app_sep2.git', branch: 'main', credentialsId: 'Git-Access-2'
            }
        }
        stage('Build') {
            steps {
                script {
                    // Log in to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        sh 'docker build -t yashmahi04/my-ecommerce-app:latest .'
                    }
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    // Push the image to Docker Hub
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        sh 'docker push yashmahi04/my-ecommerce-app:latest'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Helm deploy step (assuming Helm is set up correctly)
                    sh 'helm upgrade --install my-app ./helm/my-app'
                }
            }
        }
    }
}
