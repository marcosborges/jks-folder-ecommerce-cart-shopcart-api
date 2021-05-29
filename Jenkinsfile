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

        stage ( 'Checkout Sources' ) {
            steps {
                script {
                    sh(label: "Echo", script: 'echo 123', returnStdout: false)             
                }
            }
        }
        
        stage ( 'Review' ) {
            steps {
                script {
                    sh 'echo Review'
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
}
