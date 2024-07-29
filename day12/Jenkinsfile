pipeline {
    agent any

    environment {
        MAVEN_HOME = tool 'Maven-3.9.0' // Ensure this matches your Maven tool name
        ARTIFACTS_DIR = "/home/${env.USER}/artifacts" // Example: Store artifacts in user's home directory
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout code from GitHub repository using credentials
                git credentialsId: 'Git-Access-2', url: 'https://github.com/yashmahi88/jenkins-declarative.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                // Create ARTIFACTS_DIR if it does not exist
                sh "mkdir -p ${ARTIFACTS_DIR}"
                
                // Build the project using Maven and store artifacts in specified directory
                withEnv(["PATH+MAVEN=${MAVEN_HOME}/bin", "ARTIFACTS_DIR=${ARTIFACTS_DIR}"]) {
                    sh 'mvn clean package -Dmaven.test.skip=true -Dmaven.repo.local=${ARTIFACTS_DIR}'
                }
            }
        }

        stage('Archive Artifacts') {
            steps {
                // Check if ARTIFACTS_DIR exists and archive artifacts
                def artifactsDir = "${ARTIFACTS_DIR}"
                if (new File(artifactsDir).exists()) {
                    archiveArtifacts artifacts: "${artifactsDir}/*.jar", allowEmptyArchive: true
                } else {
                    echo "Warning: Artifacts directory not found at ${artifactsDir}. No artifacts to archive."
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline succeeded.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
