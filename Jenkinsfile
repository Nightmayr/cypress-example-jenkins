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
        stage ('checkout dockerfile test') {
            steps {
                dir('dockerfile-test') {
                    cleanWs()
                    checkout([$class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[url: 'https://github.com/Nightmayr/cypress-example-jenkins.git']]]
                    )
                }
            }
        }
        stage('Dockerfile') {
            agent {
                // dockerfile true
                dockerfile {
                    dir 'dockerfile-test'
                    reuseNode true
                }
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
        stage('manual docker build') {
            environment {
                CYPRESS_VIDEO = false
            }
            steps {
                dir('test-directory'){
                    checkout([$class: 'GitSCM',
                    branches: [[name: '*/manual-build']],
                    userRemoteConfigs: [[url: 'https://github.com/Nightmayr/cypress-example-jenkins.git']]]
                    )
                    sh 'echo $WORKSPACE'
                    sh 'docker build . -t test/cypress'
                    sh 'docker run -u "$(id -u):$(id -g)" test/cypress'
                }
            }
        }
        stage('manual docker build 2') {
            environment {
                CYPRESS_VIDEO = true
                LIBVA_DRIVER_PATH = "/usr/lib/x86_64-linux-gnu/dri"
                LIBVA_DRIVER_NAME = "i915"
            }
            steps {
                dir('test-directory-2'){
                    checkout([$class: 'GitSCM',
                    branches: [[name: '*/manual-build']],
                    userRemoteConfigs: [[url: 'https://github.com/Nightmayr/cypress-example-jenkins.git']]]
                    )
                    sh 'echo $WORKSPACE'
                    sh 'docker build . -t test/cypress'
                    sh 'docker run -u "$(id -u):$(id -g)" -e CYPRESS_VIDEO=$CYPRESS_VIDEO -e LIBVA_DRIVER_PATH=$LIBVA_DRIVER_PATH -e LIBVA_DRIVER_NAME=$LIBVA_DRIVER_NAME -v $PWD:/e2e -w /e2e test/cypress'
                }
            }
        }
    }
}