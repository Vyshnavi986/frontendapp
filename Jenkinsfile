pipeline {
    agent any

    environment {
        IMAGE_NAME = "vyshnavi986/frontend-app" // Your DockerHub username/repo
        IMAGE_TAG = "latest"
        CONTAINER_NAME = "thirsty_proskuriakova" // Name for the container on your server
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', // Replace 'main' if your branch name is different
                    url: 'https://github.com/Vyshnavi986/frontendapp.git' // Your GitHub repo URL
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .' // Uses Dockerfile in your project root
            }
        }

        stage('Push Docker Image') {
            steps {
                withDockerRegistry([ credentialsId: 'dockerhub-creds', url: '' ]) { // Must match Jenkins credentials ID
                    sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Stop old container if running
                    sh '''
                        if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
                            docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME
                        fi
                    '''
                    // Run new container
                    sh 'docker run -d -p 3000:80 --name $CONTAINER_NAME $IMAGE_NAME:$IMAGE_TAG'
                }
            }
        }
    }

    post {
        always {
            echo '✅ Frontend Docker pipeline finished.'
        }
    }
}
