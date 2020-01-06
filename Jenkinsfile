pipeline {
    agent any  stages {
        stage('Building image') {
            steps{
                script {
                    docker.build "nginx-custom" + ":$BUILD_NUMBER"
        }
      }
    }
  }
}