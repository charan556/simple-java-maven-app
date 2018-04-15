FROM java:8
WORKDIR /
ADD my-app-1.0-SNAPSHOT.jar  my-app.jar
EXPOSE 8080
RUN sh java -jar my-app-1.0-SNAPSHOT.jar
