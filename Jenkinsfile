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
            agent {
                node {
                    label 'docker'
                }
            }
            steps {
                sh 'cat /etc/os-release'
                docker.withRegistry('https://registry.hnrx.de') {
                    def customImage = docker.build("documentation-app:${env.BUILD_ID}")
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
