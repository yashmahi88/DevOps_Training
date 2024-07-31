pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-cred')
        registry = 'docker.io'  
        registryCredential = 'personal-docker'
    }

    stages {
        stage('Checkout SCM') {
            steps {
                git url: 'https://github.com/yashmahi88/day15_2.git', branch: 'master'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t yashmahi04/test15:latest .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    withDockerRegistry([credentialsId: 'docker-cred', url: 'https://index.docker.io/v1/']) {
                        sh 'docker push yashmahi04/test15:latest'
                    }
                }
            }
        }
        stage('Deploy Container') {
            steps {
                script {
                    sh 'docker run -d -p 8099:80 yashmahi04/test15:latest'
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}