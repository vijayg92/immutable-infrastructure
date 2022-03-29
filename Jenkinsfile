pipeline {
    agent any
    stages {
        stage('Code Check-in') {
            steps { 
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], userRemoteConfigs: [[url: 'https://github.com/vijayg92/datastructures-algorithms']]])
                sh('ls -ltr')
            }
        }
        stage('Template Validation') {
            steps { 
                sh('/opt/tools/packer validate -var-file=vars.json app.json') 
            }
        }
        stage('Prepare Golden Image') {
            steps { 
                sh('/opt/tools/packer build -var-file=vars.json app.json')
            }
        }
        stage('Validate Image') {
            steps { 
                sh('ruby -Ilib -Ispec -rrspec/autorun /opt/serverspec/spec/webserver_spec.rb')
            }
        }

        stage('Tag & Publish') {
            steps { 
                echo 'Prepare Golden Image'
            }
        }
        stage('Deploy Image') {
            steps { 
                echo 'Pull latest code'
            }
        }
    }
}