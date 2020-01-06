pipeline {
    agent any  
    environment {
        IMAGE_NAME = 'moshedayan/nginx-custom'
    }
    stages {
        stage('Modifing') {
            steps{
                script {
                    sh '''
                    sed -i 's/__BUILD__/${BUILD_NUMBER}/g' index.html
                    cat index.html
                    '''
                }
            }
        }
        stage('Building image') {
            steps{
                script {
                    nginx = docker.build IMAGE_NAME + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Test') {
            steps{
                script {
                    nginx.run("-p 80:80")
                    sh 'curl 127.0.0.1'
                        }
            }
        }
        // stage('Pushing image') {
        //     steps{
        //         script {
        //             withDockerRegistry([credentialsId: 'registry', url: "https://index.docker.io/v1/"]) {
        //                 customImage.push()
        //                 customImage.push('latest')
        //             }
        //         }
        //     }
        // }
    }
}