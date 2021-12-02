pipeline {
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
                sh 'node --version'
                sh 'ls'
                sh 'pwd'
                sh 'npm install retypeapp --global'
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
