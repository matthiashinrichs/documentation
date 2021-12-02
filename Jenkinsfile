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
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
