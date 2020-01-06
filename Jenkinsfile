pipeline {
    agent any  
    stages {
        stage('Building image') {
            steps{
                script {
                    // docker.build "nginx-custom" + ":$BUILD_NUMBER"
                    def customImage = docker.build("moshedayan/nginx-custom:${env.BUILD_ID}")
                    customImage.push()
                }
            }
        }
    }
}