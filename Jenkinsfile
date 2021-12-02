pipeline {
    agent any

    stages {
        stage('Build') {
            agent {
                docker {
                    image 'node:14-alpine'
                    args '-v docs:/srv'
                    reuseNode true
                }
            }
            steps {
                echo 'Building..'
                sh 'node --version'
                sh 'ls /srv'
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
