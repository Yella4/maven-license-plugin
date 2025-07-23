# Stage 1: Build the plugin
FROM maven:3.8.7-openjdk-8-slim AS builder

# Set working directory
WORKDIR /app

# Copy all project files
COPY . .

# Build the plugin (skip tests if needed)
RUN mvn clean package -DskipTests

# Stage 2: Runtime container (optional, for deployment)
# Since this is a plugin, it's usually published to a repo — but if you want to keep the JAR in a container:
FROM openjdk:8-jre-slim

# Create app directory
WORKDIR /plugin

# Copy the built JAR from the previous stage
COPY --from=builder /app/target/*.jar ./maven-license-plugin.jar

# Default command (optional)
CMD ["java", "-jar", "maven-license-plugin.jar"]
