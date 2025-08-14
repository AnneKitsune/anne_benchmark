stage('All') {
node('linux') {
    script {
        checkout scm
        env.GIT_COMMIT_MSG = sh (script: 'git log -1 --pretty=%B HEAD', returnStdout: true).trim()
        env.DISCORDHOOK = credentials('discord_hook')
    }
}

try {
timeout(time: 15, unit: 'MINUTES') {
    parallel a: {
        stage('Linux') {
            node('linux') {
                checkout scm
                sh '$ZIG version'
                sh '$ZIG build'
                sh '$ZIG build test'
            }
        }
    }, b: {
        stage('OSX') {
            node('osx') {
                checkout scm
                sh '$ZIG version'
                sh '$ZIG build'
                sh '$ZIG build test'
            }
        }
    }, c: {
        stage('Windows') {
            node('win') {
                checkout scm
                sh '$ZIG version'
                sh '$ZIG build'
                sh '$ZIG build test'
            }
        }

    }, d: {
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
  discordSend(
      webhookURL: env.DISCORDHOOK,
      description: GIT_COMMIT_MSG,
      footer: '',
      image: '',
      link: env.BUILD_URL,
      result: currentBuild.currentResult,
      scmWebUrl: '',
      thumbnail: '',
      title: JOB_NAME
  )
}
}



