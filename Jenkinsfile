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
                    args '-v $WORKSPACE/docs:/root/docs'
                    reuseNode true
                }
            }
            steps {
                echo 'Building..'
                sh 'ls'
                sh 'pwd'
                sh 'touch /root/docs/mytestfile'
                sh 'ls /root/docs'
                sh 'npm install retypeapp --global'
                sh 'cd /root/docs'
                sh 'retype build /root/docs'
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
