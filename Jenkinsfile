stage('All') {
node('linux') {
    script {
        checkout scm
        env.GIT_COMMIT_MSG = sh (script: 'git log -1 --pretty=%B HEAD', returnStdout: true).trim()
    }
}

try {
timeout(time: 15, unit: 'MINUTES') {
    parallel Linux: {
        stage('Linux') {
            node('linux') {
                checkout scm
                sh '$ZIG version'
                sh '$ZIG build'
                sh '$ZIG build test'
                sh '$ZIGBENCH anne-benchmark'
            }
        }
    }, OSX: {
        stage('OSX') {
            node('osx') {
                checkout scm
                sh '$ZIG version'
                sh '$ZIG build'
                sh '$ZIG build test'
            }
        }
    }, Windows: {
        stage('Windows') {
            node('win') {
                checkout scm
                bat '%ZIG% version'
                bat '%ZIG% build'
                bat '%ZIG% build test'
            }
        }

    }, FreeBSD: {
        stage('FreeBSD') {
            node('freebsd') {
                checkout scm
                sh '$ZIG version'
                sh '$ZIG build'
                sh '$ZIG build test'
            }
        }
    }, failFast: false


    matrix {
        axes {
            axis {
                name 'SOURCE'
                values 'linux', 'osx', 'win', 'freebsd'
            }
            axis {
                name 'TARGET'
                values 'x86_64-windows'
            }
        }
        excludes {
            exclude {
                axis { name 'SOURCE'; values 'win' }
                axis { name 'TARGET'; values 'x86_64-windows' }
            }
        }

        agent {
            label "${SOURCE}"
        }
        stages {
            stage('Crosscompile') {
                steps {
                    checkout scm
                    sh '$ZIG build -Dtarget=${TARGET}'
                }
            }
        }
    }, failFast: false
}
} catch (err) {
    currentBuild.result = 'FAILURE'
    currentBuild.currentResult = 'FAILURE'
    throw err
} finally {
    withCredentials([string(credentialsId: 'discord_hook', variable: 'DISCORDHOOK')]) {
        discordSend(
            webhookURL: DISCORDHOOK,
            description: env.GIT_COMMIT_MSG,
            //footer: '',
            //image: '',
            //link: env.BUILD_URL,
            result: currentBuild.currentResult,
            //scmWebUrl: '',
            //thumbnail: '',
            title: JOB_NAME
        )
    }
}
}



