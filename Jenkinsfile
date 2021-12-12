pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }
    agent any

    stages {
        stage('Build Content') {
            agent {
                docker {
                    image 'python:3.9-slim'
                    reuseNode true
                }
            }
            steps {
                echo 'Building..'
                sh 'pip install mkdocs-material mkdocs-mermaid2-plugin'
                sh 'mkdocs build'
            }
        }
        stage('Create Application') {
            steps {
                sh 'ls -lha'
                script {
                    docker.withRegistry('https://registry.hnrx.de', 'portus_token') {
                        def dockerImage = docker.build("documentation_app:${env.BUILD_ID}")
                        dockerImage.push()
                        dockerImage.push('latest')
                    }
                }
            }
        }
        stage('Update Application Repo') {
            steps {
                echo 'Deploying....'
                sh 'git clone git@github.com:matthiashinrichs/my-kubenetes-apps.git'
                dir('my-kubenetes-apps/documentation-app') {
                    sh "sed -i 's|image: .*\$|image: registry.hnrx.de/documentation_app:${env.BUILD_ID}|' deployment.yaml"
                    sh "git commit -am \"updated container version to ${env.BUILD_ID}\""
                    sh "git push"
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
