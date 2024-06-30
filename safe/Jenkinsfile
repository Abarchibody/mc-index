import java.text.SimpleDateFormat

def COLOR_MAP = [
  'SUCCESS': '\u001B[32m', // GREEN
  'FAILURE': '\u001B[31m', // RED
  'ABORTED': '\u001B[33m', // YELLOW
]

pipeline {
  agent any

  environment {
    DOCKER_REGISTRY = 'registry.ontryst.com'
    REPO_NAME = 'ontryst-webapp'
  }

  stages {
    stage('Setup') {
      steps {
        script {
          // Generating the timestamp for the image tag
          def dateFormat = new SimpleDateFormat("yyMMddHHmm")
          def date = new Date()
          env.TIMESTAMP = dateFormat.format(date)
        }
      }
    }

    stage('Build') {
      steps {
        script {
          docker.build("${DOCKER_REGISTRY}/${REPO_NAME}:latest").push()
          docker.build("${DOCKER_REGISTRY}/${REPO_NAME}:${env.TIMESTAMP}").push()
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
          // Update the Kubernetes deployment configuration file
          sh "sed -i 's|container_image|${DOCKER_REGISTRY}/${REPO_NAME}:${env.TIMESTAMP}|g' k8s/deploy.yml"
          sh "cat k8s/deploy.yml"
        }
        script {
          // Deploy the application to Kubernetes
          sh "kubectl apply -f k8s/deploy.yml"
        }
      }
    }
  }

  post {
    always {
      echo 'Slack notification'
      slackSend channel: '#git',
                color: COLOR_MAP[currentBuild.result],
                message: "*${currentBuild.result}:* ${env.JOB_NAME} - ${env.BUILD_NUMBER} - ${env.ENVIRONMENT} - ${env.GIT_BRANCH} - ${env.FQDN} - ${env.NAMESPACE} - ${env.SESSION_NAME} - ${env.SESSION_DOMAIN}"
      cleanWs() // Clean up workspace after build
    }
  }
}
