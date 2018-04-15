pipeline {
    agent {
        docker {
            image 'charan556/jenkins-slave' 
            args '-v /root/.m2:/root/.m2' 
        }
    }
    stages {
        stage('Build') { 
                sh 'mvn -B -DskipTests clean package' 
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
		sh 'mvn site'
	}
        stage('Publish Code Coverage Report'){
		publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false, 
                keepAll: false, reportDir: 'target/site/jacoco', reportFiles: 'index.html', 
                reportName: 'Code Coverage Report'])
	}
        stage('Publish Project Report') {
		publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false,
                keepAll: false, reportDir: 'target/site', reportFiles: 'project-reports.html', 
                reportName: 'Project Report'])
	}
	stage('Build Docker Image') {
		sh "cp ./target/my-app-1.0-SNAPSHOT.jar ."
		sh "docker build -f ./Dockerfile -t my-java-app ."
        }
	stage('Publish Docker Image') {    
		sh "docker tag my-java-app localhost:5043/charan556/my-java-app"
		sh "docker push localhost:5043/charan556/my-java-app"
	}
	stage('Run Docker Image') {
		sh "if [ \$(docker ps -aqf 'name=my-java-app') ] ; 
                    then docker rm -f  \$(docker ps -aqf 'my-java-app'); 
                    else echo \" No container found\" ; fi"

		sh "docker run -d --name my-java-app localhost:5043/charan556/my-java-app"
        }
    }
}
