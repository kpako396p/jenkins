pipeline {
  agent any
  stages {
    stage('Building image') {
      steps{
        script {
          sh "cat Dockerfile"
        }
      }
    }
    // stage('Deploy Image') {
    //   steps{
    //     script {
    //       docker.withRegistry( '', registryCredential ) {
    //         dockerImage.push()
    //       }
    //     }
    //   }
    // }
  }
}