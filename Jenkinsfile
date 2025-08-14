stage('All') {
node('linux') {
    script {
        checkout scm
        env.GIT_COMMIT_MSG = sh (script: 'git log -1 --pretty=%B HEAD', returnStdout: true).trim()
    }
}

try {
timeout(time: 15, unit: 'MINUTES') {
    parallel a: {
        stage('Linux') {
            node('linux') {
                checkout scm
                sh 'zig version'
                sh 'zig build'
                sh 'zig build test'
            }
        }
    }, b: {
        stage('OSX') {
            node('osx') {
                checkout scm
                sh 'zig version'
                sh 'zig build'
                sh 'zig build test'
            }
        }
    }, c: {
        stage('Windows') {
            node('windows') {
                checkout scm
                sh 'zig version'
                sh 'zig build'
                sh 'zig build test'
            }
        }

    }, d: {
        stage('FreeBSD') {
            node('bsd') {
                checkout scm
                sh 'zig version'
                sh 'zig build'
                sh 'zig build test'
            }
        }
    }, failFast: false
}
} finally {
  discordSend(
      webhookURL: credentials('discord_hook'),
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



