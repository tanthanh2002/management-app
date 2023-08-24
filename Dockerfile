FROM maven:3.8.1-openjdk-8 AS builder
WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN mvn clean install

CMD ["mvn","tomcat7:run"]