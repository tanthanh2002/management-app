FROM maven:3.8.1-openjdk-17-slim AS builder
WORKDIR /app
COPY pom.xml ./
COPY . .

CMD ["mvn","tomcat7:run"]