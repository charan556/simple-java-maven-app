FROM java:8
WORKDIR /
ADD my-app-1.0-SNAPSHOT.jar  my-app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/my-app.jar"]
