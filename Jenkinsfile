pipeline {
    agent none

    stages {
        stage ('All') {
            parallel {
                stage('linux') {
                    agent { label 'linux' }
                    steps {
                        sh "${ZIG} build"
                        sh "${ZIG} build test"
                    }
                }
                stage('freebsd') {
                    agent { label 'freebsd' }
                    steps {
                        sh "${ZIG} build"
                        sh "${ZIG} build test"
                    }
                }
                stage('osx') {
                    agent { label 'osx' }
                    steps {
                        sh "${ZIG} build"
                        sh "${ZIG} build test"
                    }
                }
                stage('windows') {
                    agent { label 'win' }
                    steps {
                        sh "${ZIG} build"
                        sh "${ZIG} build test"
                    }
                }
            }
        }
    }
}
