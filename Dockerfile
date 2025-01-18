FROM openjdk:11-jre-slim
WORKDIR /app
COPY target/taskmaster.jar taskmaster.jar
ENTRYPOINT ["java", "-jar", "taskmaster.jar"]
