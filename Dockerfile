# Stage 1: Build the application
FROM gradle:7.5-jdk17 as builder

# Set the working directory inside the container
WORKDIR /app

# Copy the Gradle wrapper and the build files (e.g., build.gradle, settings.gradle)
COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./

# Copy the source code
COPY src src/

# Build the application
RUN ./gradlew build --no-daemon

# Stage 2: Create the final image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file built in the previous stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Expose the port the app will run on
EXPOSE 8080

# Set the default command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
