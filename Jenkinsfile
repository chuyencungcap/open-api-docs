#!/usr/bin/env groovy

@Library('t-jenkins-shared-library') _
node {
  properties([disableConcurrentBuilds()])
  ansiColor('xterm') {
  try {
    project = "open-api-docs"
    f_compose = "docker-compose.dev.yml"
    container_name = "open-api-docs-dev"  // defined in ${f_compose}

    channel = '#open-api-docs'
    notifyBuild('STARTED', channel)

    stage('pull code') {
      scmVars = checkoutGit(scm)
    }

    // remove potential '/' in branch name (Ex: feature/bla_bla)
    branch = env.BRANCH_NAME.replaceAll(/\//, '_')
    buildNumber = env.BUILD_NUMBER
    commitHash = scmVars.GIT_COMMIT
    imageBranch = "${project}:${branch}"
    imageHash = "${project}:${commitHash}"
    imageBuild = "${project}:${branch}-build-${buildNumber}"

    switch(env.BRANCH_NAME) {
      case 'dev':
        stage('img -> dockerhub') {
          buildImage(imageBranch)
          pushImage(imageBranch)
        }
        stage('deploy uat') {
          triggerDeploy('uat', imageBuild)
        }
      break
      case 'master':
        stage('img -> dockerhub') {
          buildImage(imageBranch)
          pushImage(imageBranch)
        }
        stage('deploy production') {
          triggerDeploy('production', imageBuild)
        }
      break
    }
  } catch (e) {
    currentBuild.result = "FAILED"  // exception thrown, build failed
  throw e
  } finally {
    sh "docker-compose -p ${project} -f ${f_compose} down"
    notifyBuild(currentBuild.result, channel)  // success or failure, always send notifications
  }
  }
}
