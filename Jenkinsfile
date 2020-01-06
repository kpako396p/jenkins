pipeline {
    agent any  
    stages {
        stage('Modifing') {
            steps{
                script {
                    sh "sed -i 's/__BUILD__/${env.BUILD_ID}/g' index.html"
                }
            }
        }
        stage('Building image') {
            steps{
                script {
                    def customImage = docker.build("moshedayan/nginx-custom:${env.BUILD_ID}")
                }
            }
        }
        stage('Test image') {
            customImage.inside {
                sh 'curl 127.0.0.1' 
            }
        }
        stage('Pushing image') {
            steps{
                script {
                    withDockerRegistry([credentialsId: 'registry', url: "https://index.docker.io/v1/"]) {
                        customImage.push()
                        customImage.push('latest')
                    }
                }
            }
        }
    }
}