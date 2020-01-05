node('docker') {
 
    stage 'Checkout'
        checkout scm
    stage 'Build'
    sh "docker build -t nginx-custom:${BUILD_NUMBER} -f Dockerfile ."
}