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
                    docker.image(IMAGE_NAME).withRun('-p 9090:80') {c ->
                        sh 'curl 0.0.0.0:9090'
                    }
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