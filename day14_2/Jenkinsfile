pipeline {
    agent any
    environment {
        registry = 'docker.io'  
        registryCredential = 'docker-cred' 
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/yashmahi88/java-docker.git', branch: 'master'
            }
        }
        stage('build image') {
            steps{
                script{
                    docker.withRegistry('', registryCredential){
                        def customImage = docker.build("yashmahi04/java-app:${env.BUILD_ID}")
                        customImage.push()

                    }
                }
            }
        }
        stage('Deploy Container') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        def runContainer = docker.image("yashmahi04/java-app:${env.BUILD_ID}").run('--name day_fifteen -d')
                        echo "Container ID: ${runContainer.id}"
                    }
                }
            }
        }
    }
}
 