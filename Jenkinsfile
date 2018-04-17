pipeline {
    agent {
        docker {
            image 'maven:3.5.0' 
            args '-v /root/.m2:/root/.m2' 
        }
    }
    stages {
        stage('Build') { 
	     steps{	  
                sh 'mvn clean install' 
	     }
        }
        stage('Run Integration Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
    }
}
