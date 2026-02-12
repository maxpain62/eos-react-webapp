podTemplate (yaml: readTrusted('pod.yaml'))  {
    node (POD_LABEL) {
      stage('Checkout Source') {
      git branch: 'main', url: 'https://github.com/maxpain62/eos-react-webapp.git'
      script {
            // Capture tag into a Groovy variable
            env.GIT_TAG = sh(
                script: "git tag --sort=-creatordate | head -1",
                returnStdout: true
            ).trim()
        }
        echo "${env.GIT_TAG}"
      }
      stage ('ECR login') {
      container('aws-cli-helm') {
        sh """
          aws ecr get-login-password --region ap-south-1 | helm registry login --username AWS --password-stdin 134448505602.dkr.ecr.ap-south-1.amazonaws.com
          """
        }
      }
      stage ('build react project') {
        container('node-build') {
          sh """
            npm install
            npm run build
          """
        }
      }
      stage ('build docker image and push to ecr repository') {
        container('buildkit') {
          sh """
          ls -l && ls -l build/
          buildctl --addr tcp://buildkitd.devops-tools.svc.cluster.local:1234\
          --tlscacert /certs/ca.pem\
          --tlscert /certs/cert.pem\
          --tlskey /certs/key.pem\
          build --frontend dockerfile.v0\
          --opt filename=Dockerfile --local context=.\
          --local dockerfile=.\
          --output type=image,name=134448505602.dkr.ecr.ap-south-1.amazonaws.com/dev/eos-react-webapp:latest,push=true
          """
        }
      }
      stage ('package helm chart and push aws ecr repository') {
        container('aws-cli-helm') {
          sh """
            helm package eos-react-webapp-chart && ls -l
            helm push eos-react-webapp-0.2.0.tgz oci://134448505602.dkr.ecr.ap-south-1.amazonaws.com/dev/helm/
            aws ecr describe-images --repository-name dev/helm/eos-react-webapp --region ap-south-1
          """
        }
      }
  }
}
