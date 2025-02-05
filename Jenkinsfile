//${library.jenkins-slack-library.version}
@Library('jvva-canada-channels-bot-user-slack-connections') _

pipeline {

  agent { label 'jjva-google-jenkins-slave' }

  options {
       buildDiscarder logRotator(
           artifactDaysToKeepStr: '5',
           artifactNumToKeepStr: '5',
           daysToKeepStr: '5',
           numToKeepStr: '5')
          timestamps()
        }

  tools {
      maven 'UI_Maven3..9.9'
  }

  environment {
    //Apps environments properties
    myApp="mss-java-app"
    sonarName="jjva-mss-java-web-report-app"
    dockerName="jjva-mss-java-web-img-app"
    nexusName="jjva-mss-java-warfile-app"
    promeName="prometheus-server"
    alertM="prometheus-alertmanager"
    alertName="prometheus-alertmanager"
    graName="grafana"
    //website url properties 
    webSite="http://mdb.eagunu4live.com/java-web-app"
    promeLink="http://prome.eagunu4live.com"
    grafanaURL="http://grafana.eagunu4live.com"
    alertURL="http://alert.eagunu4live.com"
    alartLink="http://alert.eagunu4live.com"
    dockerlink="https://hub.docker.com/repository/docker/eagunuworld/jjva-mss-java-web-app"
    //Codes environment properties
    GIT_COMMIT = "${GIT_COMMIT}"
    GIT_BRANCH="${GIT_BRANCH}"
    GIT_PREVIOUS_SUCCESSFUL_COMMIT   = "${GIT_PREVIOUS_SUCCESSFUL_COMMIT}"
    BUILD_NUMBER = "${env.BUILD_ID}"
    //eagunu docker registry repository login
    registry = "eagunuworld/jjva-mss-java-web-img-app"
    //eagunu dockerhub registry
    registryCredential = 'eagunuworld-docker-username-and-pwd'
    dockerImage = ''
    //latest_version_update
    imageVersion = "eagunuworld/jjva-mss-java-web-img-app:v$BUILD_NUMBER"
    }

   stages {
    stage('Cloning Git') {
            steps {
                ////checkout([$class: 'GitSCM', branches: [[name: '*/prod-master']], extensions: [], userRemoteConfigs: [[credentialsId: 'democalculus-github-login-creds', url: 'https://github.com/democalculus/kubana-maven-web-app.git']]])
                git credentialsId: 'GIT_CREDENTIALS', url:  'https://github.com/argocd-2025/argocd-demo.git',branch: 'main'
            }
        }

    stage ('Build wep app war file') {
      steps {
       sh 'mvn clean package'
        }
     }
      stage('Building our image') {
           steps{
                script {
                   dockerImage = docker.build registry + "$BUILD_NUMBER"
                  }
              }
           }

      // stage('QA approve') {
      //        steps {
      //          notifySlack("Do you approve QA deployment? $registry/job/$BUILD_NUMBER", [])
      //            input 'Do you approve QA deployment?'
      //            }
      //        }

      stage('Deploy our image') {
         steps{
             script {
                docker.withRegistry( '', registryCredential ) {
               dockerImage.push()
              }
            }
           }
         }

    stage('Cleaning  up docker Images') {
        steps{
           sh 'docker rmi  ${imageVersion}'
           }
         }
    stage('list all file path') {
             steps{
                sh 'ls -lart'
                }
              }

 }  //This line end the pipeline stages
  post {   //This line start the post script uncommit later
    success {
      script {
        //* Use slackNotifier.groovy from shared library and provide current build result as parameter */
        env.failedStage = "none"
        env.emoji = ":white_check_mark: :tada: :thumbsup_all:"
        sendNotification currentBuild.result
      }
      }

    // failure {
    //}
  }  //this line close post script stage
}    //This line close the jenkins pipeline
