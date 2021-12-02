pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:17'
                    reuseNode true
                }
            }
            steps {
                echo 'Building..'
                sh 'npm install retypeapp --global'
                sh 'retype build docs'
                sh 'ls -lha docs/'
            }
        }
        stage('Test') {
            steps {
                sh 'cat /etc/os-release'
                script {
                    docker.withRegistry('https://registry.hnrx.de', 'portus_token') {
                        def dockerImage = docker.build("documentation_app:${env.BUILD_ID}")
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }

    post {
        // Clean after build
        always {
            cleanWs(cleanWhenNotBuilt: false)
        }
    }
}
