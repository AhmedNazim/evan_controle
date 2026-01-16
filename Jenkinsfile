pipeline {
    agent { label 'docker-agent' } // nom de ton agent déjà configuré

    environment {
        WORKSPACE_DIR = '/workspace' // répertoire de travail sur l'agent
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/tonuser/ton-repo-terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir("${WORKSPACE_DIR}") {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Lint Terraform') {
            steps {
                dir("${WORKSPACE_DIR}") {
                    sh 'tflint'
                }
            }
        }

        stage('Security Scan') {
            steps {
                dir("${WORKSPACE_DIR}") {
                    sh 'checkov -d .'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline terminée'
        }
        success {
            echo 'Pipeline réussie ! ✅'
        }
        failure {
            echo 'Pipeline échouée ❌'
        }
    }
}
