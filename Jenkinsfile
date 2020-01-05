pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'docker:dind'
                }
            }
            steps {
                sh 'docker build -t nginx:custom .'
            }
        }
    }
}