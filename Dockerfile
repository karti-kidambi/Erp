# Use a Maven image with OpenJDK 21 to build and run the application
FROM maven:3.9.6-eclipse-temurin-21

# Set the working directory
WORKDIR /app

# Copy the source code
COPY . .

# Run Maven compile and package to download dependencies and build targets
RUN mvn clean package -DskipTests

# Expose the default Spring Boot port
EXPOSE 8888

# Set environment variable for server port
ENV PORT=8888

# Run the Spring Boot application using spring-boot:run to ensure Tomcat can locate
# and compile JSP files from the src/main/webapp directory.
CMD ["mvn", "spring-boot:run"]
