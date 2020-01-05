pipeline {
    agent none
    stages {
    stage('Building image') {
        steps{
        script {
            docker.build nginx:custom + ":$BUILD_NUMBER"
        }
        }
    }
    }
}