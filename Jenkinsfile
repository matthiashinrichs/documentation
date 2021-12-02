pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:17'
                    args '-v $HOME:/srv'
                    reuseNode true
                }
            }
            steps {
                echo 'Building..'
                sh 'node --version'
                sh 'ls /srv'
                sh 'ls'
                sh 'pwd'
                sh 'npm install retypeapp --global'
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
