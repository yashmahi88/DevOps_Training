pipeline {
    agent any
    stages {
        stage('Clone Repository') {
            steps {
                git url:'https://github.com/yashmahi88/java-app.git', branch: 'master'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t yashmahi04/java-app .'
                script{
                    docker.withRegistry('',Docker_credentials){
                        def customImage = docker.build("yashmahi04/java-app .")
                        customImage.push()
                    }
            }
        }
    }
        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred')]) {
                    sh ' docker login'
                    sh ' docker push yashmahi04/java-app'
                }
            }
        }
        stage('Deploy Container') {
            steps {
                sh 'docker run -d -p 8089:8080 yashmahi04/java-app'
            }
        }
    }
}
