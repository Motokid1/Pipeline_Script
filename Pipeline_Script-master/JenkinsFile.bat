pipeline {
    agent any

    stages {
        stage('Git-Checkout') {
            steps {
                echo 'Checking out Git Repo'
                git credentialsId: 'Motokid1', url:'https://github.com/Motokid1/Pipeline_Script.git'
            }
        }
        
        stage('Build') {
            steps {
                echo "Building the checked-out project"
                bat 'Pipeline_Script-master/Build.bat'
            }
        }
        
        stage('Unit-Test') {
            steps {
                echo "Running JUnit Tests"
                bat 'Pipeline_Script-master/Unit.bat'
            }
        }
        
        stage('Quality-Gate') {
            steps {
                echo "Verifying Quality Gates"
                bat 'Pipeline_Script-master/Quality.bat'
            }
        }
        
        stage('Deploy') {
            steps {
                echo "Deploying to Stage Environment for more tests"
                bat 'Pipeline_Script-master/Deploy.bat'
            }
        }
    }

    post {
        always {
            echo 'This will always run'
        }
        success {
            echo 'This will run only if all stages succeed'
        }
        failure {
            echo 'This will run only if any stage fails'
        }
    }
}
