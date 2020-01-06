pipeline {
    agent any  
    environment {
        IMAGE_NAME = 'moshedayan/nginx-custom'
    }
    stages {
        stage('Building image') {
            steps{
                script {
                    withDockerRegistry([credentialsId: 'registry', url: "https://index.docker.io/v1/"]) {
                        nginx = docker.build IMAGE_NAME + ":$BUILD_NUMBER"      
                        nginx.push()
                        nginx.push('latest')
                    }
                }
            }
        }
        stage('Run nginx') {
            steps{
                script {
                    docker.image(IMAGE_NAME).withRun('-p 8000:80') { c ->
                        sh 'nginx -v'
                        sh 'curl 0.0.0.0'
                    }            
                }
            }
        }
    }
}