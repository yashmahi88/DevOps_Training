pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'docker-cred'
        DOCKER_IMAGE = 'yashmahi04/java-app'
    }
    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/yashmahi88/java-app.git', branch: 'master'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def customImage = docker.build("${DOCKER_IMAGE}")
                    customImage.push('latest')
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh 'docker run -d -p 8089:8080 ${DOCKER_IMAGE}:latest'
            }
        }
    }
}
