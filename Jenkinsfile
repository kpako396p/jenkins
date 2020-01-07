pipeline {
    agent any  
    environment {
        IMAGE_NAME = 'moshedayan/nginx-custom'
    }
    stages {
        stage('Build') {
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
        stage('Test') {
            steps{
                script {
                    docker.image(IMAGE_NAME).withRun('-p 8000:80 --name nginx-custom') { c ->
                        sh '''
                        docker exec nginx-custom nginx -v
                        '''
                    }            
                }
            }
        }
        stage('Deploy') {
            steps{
                script {
                    sh '''
                    docker run -tid -p 8000:80 --name nginx-custom-$BUILD_NUMBER $IMAGE_NAME:latest
                    docker exec nginx-custom-$BUILD_NUMBER apk add --no-cache curl
                    docker exec nginx-custom-$BUILD_NUMBER curl -s -o /dev/null -w "%{http_code}" 0.0.0.0
                    '''
                }
            }
        }
        post {
            always {
                // withCredentials([usernamePassword(credentialsId: 'jenkins_login', usernameVariable: 'NUSER', passwordVariable: 'NPASS')]) {
                withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId:'jenkins_login', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                    sh 'echo $USERNAME  $PASSWORD'
    // }
    //                 script{echo 'One way or another, I have finished'
    //                 deleteDir()
    //                 STABLE_BUILD=$(curl '${NUSER}:${NPASS}@0.0.0.0:8080/job/nginx/lastSuccessfulBuild/api/json' | jq -r '.id')
    //                 echo $STABLE_BUILD
                }
            }
            success {
                echo 'I succeeeded!'
            }
            unstable {
                echo 'I am unstable :/'
            }
            // failure {
            //     withCredentials([string(credentialsId: 'jenkins_login', variable: 'NUSER'),string(credentialsId: 'jenkins_login', variable: 'NPASS')]) {
            //         echo 'One way or another, I have finished'
            //         deleteDir()
            //         STABLE_BUILD=$(curl '${NUSER}:${NPASS}@0.0.0.0:8080/job/nginx/lastSuccessfulBuild/api/json' | jq -r '.id')
            //         echo $STABLE_BUILD
            //     }
            // }
            changed {
                echo 'Things were different before...'
            }
        }
        }
}