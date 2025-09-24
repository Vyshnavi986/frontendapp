pipeline {
    agent any

    environment {
        IMAGE_NAME = "vyshnavi986/frontend-app" // DockerHub repo
        IMAGE_TAG = "latest"
        CONTAINER_NAME = "thirsty_proskuriakova"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/Vyshnavi986/frontendapp.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME%:%IMAGE_TAG% ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([ credentialsId: 'dockerhub-creds', url: '' ]) {
                    bat "docker push %IMAGE_NAME%:%IMAGE_TAG%"
                }
            }
        }

        stage('Deploy Container') {
            steps {
                bat """
                docker stop %CONTAINER_NAME% || echo Container not running
                docker rm %CONTAINER_NAME% || echo Container already removed
                docker run -d -p 3000:3000 --name %CONTAINER_NAME% %IMAGE_NAME%:%IMAGE_TAG%
                """
            }
        }
    }

    post {
        always {
            echo "✅ Frontend Docker pipeline finished."
        }
    }
}
