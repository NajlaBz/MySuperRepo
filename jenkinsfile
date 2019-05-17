import groovy.json.JsonOutput
def notifyBuild(String buildStatus = 'STARTED') {
   // build status of null means successful
   buildStatus =  buildStatus ?: 'SUCCESSFUL'
 
   // Default values
   def colorName = 'RED'
   def colorCode = '#FF0000'
   def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
   def summary = "${subject} (${env.BUILD_URL})"
   def details = """<p>STARTED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]':</p>
     <p>Check console output at "<a href="${env.BUILD_URL}">${env.JOB_NAME} [${env.BUILD_NUMBER}]</a>"</p>"""
 
   // Override default values based on build status
   if (buildStatus == 'STARTED') {
     color = 'YELLOW'
     colorCode = '#FFFF00'
   } else if (buildStatus == 'SUCCESSFUL') {
     color = 'GREEN'
     colorCode = '#00FF00'
   } else {
     color = 'RED'
     colorCode = '#FF0000'
   }
 
   // Send notifications
   slackSend (color: colorCode, message: summary)
 
 }


pipeline {
    agent { label 'master' }
     
    stages {
      stage('checkout') {
          steps {
                  notifyBuild('STARTED')
                  git branch: 'master',  credentialsId: '3dabe90d-041b-4960-974f-2764e857cb70' , url: 'git@github.com:NajlaBz/terratest.git'
             
          }
        }

    stage('install_deps') {
        steps {
                sh "sudo apt install wget zip python-pip -y"
                sh "cd /tmp"
                sh "curl -o terraform.zip https://releases.hashicorp.com/terraform/0.11.11/terraform_0.11.11_linux_amd64.zip"
                sh "unzip terraform.zip"
                sh "sudo mv terraform /usr/bin"
                sh "rm -rf terraform.zip"
                sh 'terraform --version'
        }
    }
        
         stage('Provision infrastructure') {
             
            steps {
                sh 'terraform init'
                sh 'terraform plan -out=plan'
                sh 'terraform apply plan'
                sh 'terraform destroy -auto-approve'
                 notifyBuild(currentBuild.result)
             
            }
        }
        
      
      
    }
}

