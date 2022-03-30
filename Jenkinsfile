pipeline {

    stages {
        // Pull latest code
        stage('Code Check-in') {
            steps { 
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], userRemoteConfigs: [[url: 'https://github.com/vijayg92/immutable-infrastructure']]])
                sh('ls -ltr')
            }
        }
        // Validate Packer template
        stage('Template Validation') {
            steps { 
                withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh script: 'cd packer/webserver/ && /opt/tools/packer validate -var-file=vars.json app.json', returnStatus: true
                }
            }
        }
        // Build Golden Image
        stage('Build Golden Image') {
            steps { 
                withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh script: 'cd packer/webserver/ && /opt/tools/packer build -var-file=vars.json app.json', returnStatus: true
                }
            }
        }
        // Validate Terraform Templates
        stage('Validate') {
            steps { 
                withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh script: 'cd terraform/webserver/ && /opt/tools/terraform plan -auto-approve', returnStatus: true
                }
            }
        }
        // Deploy golden ami to AWS cloud
        stage('Deploy') {
            steps { 
                withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh script: 'cd terraform/webserver/ && /opt/tools/terraform apply -auto-approve, returnStatus: true
                }
            }
        }
    }
}