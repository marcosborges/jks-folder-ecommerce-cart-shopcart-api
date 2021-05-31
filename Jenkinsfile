pipeline {

    agent any

    options {
        skipStagesAfterUnstable()
        preserveStashes(buildCount: 10) 
        buildDiscarder(logRotator(numToKeepStr:'10')) 
        disableConcurrentBuilds()
        withFolderProperties()
        timeout(time: 1, unit: 'HOURS') 
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
                    
                    echo sh(script: 'env|sort', returnStdout: true)
                    
                    echo("DB_HOSTNAME: ${env.DB_HOSTNAME}")
                    sh '''
                        echo DB_PASSWORD
                        echo $DB_PASSWORD | base64
                    '''
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
                    sh label: 'Validate tests', script: 'make tests'
                    sh label: 'Validate SAST', script: 'make sast'
                    sh label: 'Validate Build', script: 'make build'
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
                    sh label: 'Build container', script: 'make build'
                }
            }
        }
        
        stage ( 'Registry' ) {
            steps {
                script {
                    sh label: 'Registry container image', script: 'make registry'
                }
            }
        }
        
        stage ( 'Deploy' ) {
            steps {
                script {
                    sh label: 'Deploy container image', script: 'make deploy'
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
