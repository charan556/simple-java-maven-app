pipeline {
    agent {
        docker {
            image 'charan556/jenkins-slave' 
            args '-v /root/.m2:/root/.m2' 
        }
    }
    stages {
        stage('Build') { 
	     steps{	  
                sh 'mvn -B -DskipTests clean package' 
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
	stage('Generate Reports') {
	     steps{	  
		sh 'mvn site'
	     }
	}
        stage('Publish Code Coverage Report'){
	     steps{	  
		publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false, 
                keepAll: false, reportDir: 'target/site/jacoco', reportFiles: 'index.html', 
                reportName: 'Code Coverage Report'])
	     }
	}
        stage('Publish Project Report') {
	     steps{	  
		publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false,
                keepAll: false, reportDir: 'target/site', reportFiles: 'project-reports.html', 
                reportName: 'Project Report'])
	     }
	}
	stage('Build Docker Image') {
	     steps{	  
		sh "cp ./target/my-app-1.0-SNAPSHOT.jar ."
		sh "docker build -f ./Dockerfile -t my-java-app ."
	     }
        }
	stage('Run Docker Image') {
	     steps{	    
		sh "docker run -d --name my-java-app /usr/bin/java -jar my-app.jar"
	     }
        }
    }
}
