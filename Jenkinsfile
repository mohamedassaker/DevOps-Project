pipeline {
  agent any
  
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
  }
  
  tools {
    go 'go'
  }

  stages {
    stage('Clone') {
      steps {
        git branch: 'main', url: 'https://github.com/mohamedassaker/DevOps-Project'
      }
    }

    stage('Build') {
      steps {
        catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
          script {
            sh 'cd /var/jenkins_home/workspace/Internship-Pipeline'
            sh 'docker-compose build'
          }
        }
      }
    }
    
    stage('Push Image') {
      steps {
        catchError(buildResult: 'FAILURE', stageResult: 'FAILURE') {
          script {
            withDockerRegistry([credentialsId: 'dockerhub-credentials', url: 'https://registry.hub.docker.com']) {
              docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-credentials') {
                def image = docker.image("m8122000/go_app:latest")
                image.push()
              }
            }
          }
        }
      }
    }
  }
}