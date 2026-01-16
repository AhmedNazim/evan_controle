pipeline {
    agent { label 'docker-agent' } // nom de ton agent déjà configuré

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/WillBero/evan_controle.git'
            }
        }


        stage('Lint Terraform') {
            steps {
                    sh 'tflint'
                }
            }
        

        stage('Security Scan') {
            steps {
                    sh 'checkov -d .'               
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
