pipeline {
    agent any
    stages {
        withCredentials([string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID'), string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY')]) {
            // Pull latest code
            stage('Code Check-in') {
                steps { 
                    checkout([$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[url: 'https://github.com/vijayg92/datastructures-algorithms']]])
                    sh('ls -ltr')
                }
            }
            // Validate Packer template
            stage('Template Validation') {
                
                    steps { 
                        sh('/opt/tools/packer validate -var-file=vars.json app.json') 
                    }
                }
            // Build Golden Image
            stage('Prepare Golden Image') {
                steps { 
                    sh('/opt/tools/packer build -var-file=vars.json app.json')
                }
            }
            // Tag image and publish to AWS
            stage('Tag & Publish') {
                steps { 
                    echo 'Prepare Golden Image'
                }
            }
            // Deploy Image in AWS Cloud
            stage('Deploy Image') {
                steps { 
                    echo 'Pull latest code'
                }
            }
    
        }
    }
}