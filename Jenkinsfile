#!groovy

@Library('github.com/red-panda-ci/jenkins-pipeline-library@v3.1.6') _

// Initialize global config
cfg = jplConfig('dc-mdline', 'bash', '', [slack: '#integrations', email:'redpandaci+dc-mdline@gmail.com'])

pipeline {
    agent none

    stages {
        stage ('Initialize') {
            agent { label 'docker' }
            steps  {
                jplStart(cfg)
            }
        }
        stage ('Build') {
            agent { label 'docker' }
            steps {
                script {
                    jplDockerPush (cfg, "kairops/dc-mdline", "test", ".", "https://registry.hub.docker.com", "cikairos-docker-credentials")
                }
            }
        }
        stage ('Test') {
            agent { label 'docker' }
            steps  {
                sh 'bin/test.sh'
            }
        }
        stage ('Release confirm') {
            when { expression { cfg.BRANCH_NAME.startsWith('release/v') || cfg.BRANCH_NAME.startsWith('hotfix/v') } }
            steps {
                jplPromoteBuild(cfg)
            }
        }
        stage ('Make release'){
            agent { label 'docker' }
            when { branch 'release/new' }
            steps {
                script { cfg.releaseTag = sh (script: "kd get-next-release-number .", returnStdout: true).trim() }
                jplDockerPush (cfg, "kairops/dc-mdline", cfg.releaseTag.substring(1), ".", "https://registry.hub.docker.com", "cikairos-docker-credentials")
                jplDockerPush (cfg, "kairops/dc-mdline", "latest", ".", "https://registry.hub.docker.com", "cikairos-docker-credentials")
                jplMakeRelease(cfg, true)
            }
        }
    }

    post {
        always {
            jplPostBuild(cfg)
        }
    }

    options {
        timestamps()
        ansiColor('xterm')
        buildDiscarder(logRotator(artifactNumToKeepStr: '20',artifactDaysToKeepStr: '30'))
        disableConcurrentBuilds()
        timeout(time: 1, unit: 'DAYS')
    }
}
