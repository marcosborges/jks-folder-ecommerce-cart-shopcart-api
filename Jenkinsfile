pipeline {

    agent any

    options {
        preserveStashes(buildCount: 10) 
        buildDiscarder(logRotator(numToKeepStr:'10')) 
        disableConcurrentBuilds()
    }

    environment {
        APP_NAME = readJSON(file: 'package.json').name.trim()
        APP_VERSION = readJSON(file: 'package.json').version.trim()
    }

    stages {

        stage ( 'Review' ) {
            steps {
                script {
                    sh 'echo Review'
                }
            }
            post {
                success {
                    sh 'echo Review OK'
                }
                failure {
                    sh 'echo Review FAILURE'
                }
            }
        }
        
        stage ( 'Build' ) {
            steps {
                script {
                    sh 'echo Build'
                }
            }
        }
        
        stage ( 'Registry' ) {
            steps {
                script {
                    sh 'echo Registry'
                }
            }
        }
        
        stage ( 'Deploy' ) {
            steps {
                script {
                    sh 'echo Deploy'
                }
            }
        }
    }

    post {
        success {
            script {
                sh 'echo SUCCESS'
            }
            cleanWs()
        }
        failure {
            sh 'echo FAILURE'
        }
    }
}
