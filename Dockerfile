# Use the OpenJDK 8 with Alpine Linux as the base image

FROM maven:3.8.1-openjdk-17-slim AS builder
WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN mvn clean install

FROM openjdk:8-jre-alpine
WORKDIR /app
# copy jar from the first stage
COPY --from=builder /app/target/*.jar /app/app.jar

# Expose port 8080 for accessing the Struts2 application
EXPOSE 8080

# Start the Tomcat server and run the Struts2 application
CMD ["catalina.sh", "run"]