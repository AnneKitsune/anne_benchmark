stage('All') {
node('linux') {
    script {
        checkout scm
        env.GIT_COMMIT_MSG = sh (script: 'git log -1 --pretty=%B HEAD', returnStdout: true).trim()
    }
}

try {
timeout(time: 15, unit: 'MINUTES') {
    matrix {
        axes {
            axis {
                name 'SOURCE'
                values 'linux', 'osx', 'win', 'freebsd'
            }
            axis {
                name 'TARGET'
                values 'x86_64-windows', 'x86_64-linux', 'x86_64-macos', 'x86_64-freebsd'
            }
        }
        excludes {
            //exclude {
                //axis { name 'SOURCE'; values 'win' }
                //axis { name 'TARGET'; values 'x86_64-windows' }
            //}
        }

        agent {
            label "${SOURCE}"
        }
        stages {
            stage('Checkout') {
                checkout scm
            }
            stage('Compile') {
                steps {
                    if (isUnix()) {
                        sh '$ZIG build -Dtarget=${TARGET}'
                    } else {
                        bat '%ZIG% build -Dtarget=${TARGET}'
                    }
                }
            }
            stage('Test') {
                when {
                    expression {
                        (env.SOURCE == 'linux' && env.TARGET == 'x86_64-linux')
                        || (env.SOURCE == 'win' && env.TARGET == 'x86_64-windows')
                        || (env.SOURCE == 'osx' && env.TARGET == 'x86_64-macos')
                        || (env.SOURCE == 'freebsd' && env.TARGET == 'x86_64-freebsd')
                    }
                    beforeAgent true
                }
                steps {
                    if (isUnix()) {
                        sh '$ZIG build test'
                    } else {
                        bat '%ZIG% build test'
                    }
                }
            }
            stage('Benchmark') {
                when {
                    expression { env.SOURCE == 'linux' && env.TARGET == 'x86_64-linux' }
                    beforeAgent true
                }
                steps {
                    sh '$ZIGBENCH anne-benchmark'
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



