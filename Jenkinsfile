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
                    args '-v $HOME/docs:/root/docs'
                    reuseNode true
                }
            }
            steps {
                echo 'Building..'
                sh 'ls'
                sh 'pwd'
                sh 'touch mytestfile'
                sh 'ls /root'
                sh 'npm install retypeapp --global'
                sh 'retype build $HOME/docs'
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
