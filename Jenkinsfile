pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "smitha8090/myapp"
        // Use the ID of the credentials stored in Jenkins
        DOCKER_HUB_CREDS = 'dockerhub-creds' 
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Smitha876/dockerRepo.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // It's cleaner to capture the image object
                    app = docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}")
                    app.tag("latest")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // This handles login, pushing, and logout automatically
                    docker.withRegistry('', DOCKER_HUB_CREDS) {
                        app.push("${BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Image ${DOCKER_IMAGE} successfully pushed!"
        }
        failure {
            echo 'Pipeline failed. Check the console output for errors.'
        }
    }
}