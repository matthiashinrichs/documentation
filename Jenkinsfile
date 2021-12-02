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
                sh 'git clone git@github.com:matthiashinrichs/my-kubenetes-apps.git'
                dir(my-kubenetes-apps/documentation-app) {
                    sh 'ls -al'
                    sh 'cat deployment.yaml | sed \'s/image: .*$/image: registry.hnrx.de/documentation_app:${env.BUILD_ID}/g\' > deployment-new.yaml'
                    sh 'mv deployment-new.yaml deployment.yaml'
                    sh 'git commit -am "updated container version to ${env.BUILD_ID}"'
                    sh 'git push'
                }
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
