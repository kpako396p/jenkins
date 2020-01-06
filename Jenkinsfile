pipeline {
    agent any  
    stages {
        stage('Building image') {
            steps{
                script {
                    withDockerRegistry([credentialsId: 'registry', url: "https://index.docker.io/v1/"]) {
                        // docker.build "nginx-custom" + ":$BUILD_NUMBER"
                        def customImage = docker.build("moshedayan/nginx-custom:${env.BUILD_ID}")
                        customImage.push()
                        customImage.push('latest')
                    }
                }
            }
        }
        stage('Run and test') {
            steps{
                script {
                    sh '''
                    docker pull moshedayan/nginx-custom:latest
                    docker run -tid -p 80:80 --name nginx-custom moshedayan/nginx-custom:latest
                    curl 127.0.0.1
                    docker kill nginx-custom
                    '''
                }
            }
        }
    }
}