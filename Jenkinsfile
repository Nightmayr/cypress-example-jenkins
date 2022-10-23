pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    stages {
        stage ('checkout') {
            steps {
                cleanWs()
                checkout([$class: 'GitSCM',
                branches: [[name: '*/main']],
                userRemoteConfigs: [[url: 'https://github.com/Nightmayr/cypress-example-jenkins.git']]]
                )
            }
        }
        stage('Dockerfile') {
            agent {
                dockerfile true
                // reuseNode true
                // docker { image 'cypress/base:10.0.0' }
                // docker { dockerfile true }
            }
            steps {
                // checkout([$class: 'GitSCM',
                // branches: [[name: '*/main']],
                // userRemoteConfigs: [[url: 'https://github.com/Nightmayr/cypress-example-jenkins.git']]]
                // )
                sh 'echo $USER'
                sh 'echo $UID'
                sh 'cat cypress.env.json'
                sh 'cat /etc/passwd'
                // sh 'npm install'
                sh 'cypress version'
                sh 'cypress info'
                sh 'cypress run'
                // script {
                //     docker.image('cypress/included:10.10.0').inside{
                //         checkout([$class: 'GitSCM',
                //         branches: [[name: '*/main']],
                //         userRemoteConfigs: [[url: 'https://github.com/Nightmayr/cypress-example-jenkins.git']]]
                //         )
                //         sh 'chown -R 975:974 "/.npm"'
                //         sh 'npm install'
                //         sh 'cypress run'
                //     }
            }
                // sh 'cypress version'
        }
    }
}