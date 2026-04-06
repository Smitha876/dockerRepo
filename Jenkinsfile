pipeline {
    agent any
    
    environment {
        DOCKER_CREDS = credentials('dockerhub-creds')
        REGISTRY = "smitha8090/myapp"
    }
    
    stages {
        stage('Clone') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                bat "docker build -t %REGISTRY%:latest ."
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                // This uses the credentials we updated to 'rakshaa21'
                bat "echo %DOCKER_CREDS_PSW% | docker login -u %DOCKER_CREDS_USR% --password-stdin"
                bat "docker push %REGISTRY%:latest"
            }
        }
    }
    
    // Ensure this 'post' block is BEFORE the final closing brace of the pipeline
    post {
        always {
            // This needs the 'node' context to run 'bat'
            bat "docker rmi %REGISTRY%:latest || exit 0"
        }
    }
}