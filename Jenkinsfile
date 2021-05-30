pipeline {

    agent any

    options {
        preserveStashes(buildCount: 10) 
        buildDiscarder(logRotator(numToKeepStr:'10')) 
        disableConcurrentBuilds()
        withFolderProperties()
    }
    
    environment {
        APP_NAME = readJSON(file: 'package.json').name.trim()
        APP_VERSION = readJSON(file: 'package.json').version.trim()
        GLOBAL_VALUE = credentials('GLOBAL_VALUE')
        DB_PASSWORD = credentials('DB_PASSWORD')
        JKS_USERID = sh(script:"""id -u jenkins """, returnStdout: true).trim()
        JKS_GROUPID = sh(script:"""id -g jenkins """, returnStdout: true).trim()
    }

    stages {
        stage ( 'Init' ) {
            steps {
                script {
                    
                    echo("DB_HOSTNAME: ${env.DB_HOSTNAME}")
                    sh 'echo $GLOBAL_VALUE | base64'
                    sh 'echo DB_PASSWORD'
                    sh 'echo $DB_PASSWORD | base64'
                }
                configFileProvider(
                    [configFile(fileId: 'maven-settings', variable: 'MAVEN_SETTINGS')]) {
                    sh 'echo $MAVEN_SETTINGS'
                }
            }
        }
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
