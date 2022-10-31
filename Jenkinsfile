pipeline {
  agent any
    stages {
        stage('SCM CHECK') {
             steps{
                script{
                    checkout([$class: 'GitSCM', branches: [[name: '*/main']],
                        userRemoteConfigs: [[
                            url: 'https://github.com/hazem-soussi/lab2_cd']]])
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
        stage('Docker') {
             steps{
                script{
                    sh "sudo ansible-playbook ansible/docker.yml -i ansible/inventory/host.yml"
                }
            }
        }
        stage('DockerHub push') {
             steps{
                script{
                    sh "ansible-playbook ansible/docker-registry.yml -i ansible/inventory/host.yml"
                }
            }
        }
       }
      }
