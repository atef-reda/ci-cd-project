pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = 'eu-west-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/atef-reda/ci-cd-project'
            }
        }

        stage('Terraform Init & Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

stage('Update Ansible Inventory') {
    steps {
        dir('terraform') {
            script {
                // Get Terraform output (ensure same dir as state file)
                def ip = sh(script: "terraform output -raw instance_ip", returnStdout: true).trim()
                
                // Write inventory file in ansible directory
                sh """
                    echo "[ec2]" > ../ansible/inventory.ini
                    echo "${ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/my-key.pem" >> ../ansible/inventory.ini
                """
            }
        }
    }
}


        stage('Run Ansible Playbook') {
            steps {
                dir('ansible') {
                    sh 'ansible-playbook -i inventory.ini playbook.yml'
                }
            }
        }

        stage('Destroy Infrastructure') {
            when {
                expression { return params.DESTROY == true }
            }
            steps {
                dir('terraform') {
                    sh 'terraform destroy -auto-approve'
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished"
        }
    }
}

