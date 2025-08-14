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
}
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



