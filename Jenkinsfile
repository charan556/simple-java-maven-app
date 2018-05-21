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
	stage('Build Docker Image') {
		 steps{	  
				sh "cp ./target/my-app-1.0-SNAPSHOT.jar ."
				sh "docker build -f ./Dockerfile my-java-app ."
			 }
		}
		stage('Run Docker Image') {
			 steps{	  
				sh "docker run -d --name my-java-app java -jar my-app.jar"
			 }
		}
	}    
}
