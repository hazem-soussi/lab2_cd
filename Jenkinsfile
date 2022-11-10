pipeline {
  agent any
    environment {
      DOCKER_TAG = getVersion()
    }
  
    stages {
        stage('SCM CHECK') {
             steps{
                script{
                /*   checkout([$class: 'GitSCM', branches: [[name: '*/main']],
                        userRemoteConfigs: [[
                            url: 'https://github.com/hazem-soussi/lab2_cd']]]) */
                 git branch: 'main', credentialsId: 'git_git_hazem', url: 'https://github.com/hazem-soussi/lab2_cd'
                  
                }
            }
        }
        stage('Install') {
             steps{
                script{
                    sh "sudo npm install"
                }
            }
        }
        stage('Build') {
             steps{
                script{
                    sh "sudo ansible-playbook Ansible/build.yml -i Ansible/inventory/host.yml"
                }
            }
        }
       /* stage('Docker') {
             steps{
                script{
                    sh "sudo ansible-playbook Ansible/docker.yml -i Ansible/inventory/host.yml"
                }
            }
        }
        stage('push TODockerHub ') {
             steps{
                script{
                    sh "ansible-playbook Ansible/docker-registry.yml -i Ansible/inventory/host.yml"
                }
            }
        }*/
      
      
      stage('Docker Build'){
            steps{
                sh "docker build . -t hazem1998/livraison:${DOCKER_TAG} "
            }
        }
        
        stage('DockerHub Push'){
            steps{
              
              
              withCredentials([string(credentialsId: 'zooma_password', variable: 'hazem')]) {
                    sh "docker login -u hazem1998 -p ${hazem}"
              }
                sh "docker push hazem1998/livraison:${DOCKER_TAG} "
            }
        }
        
        stage('Docker Deploy'){
          
          
          
          
          
          
            steps{
              
              ansiblePlaybook extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'lab2_cd/Ansible/inventory/host.yml', playbook: 'deploy-docker.yml'
            //  ansiblePlaybook extras: 'DOCKER_TAG=""', installation: 'ansible', inventory: 'lab2_cd/Ansible/inventory/host.yml', playbook: 'deploy-docker.yml'

             // ansiblePlaybook credentialsId: 'dev-server', disableHostKeyChecking: true, 
             //   extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
            }
        }
      
      
      
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}

