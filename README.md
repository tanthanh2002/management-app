# Management Application

## Pre requirements

Install JDK 8 : [Link](https://www.oracle.com/java/technologies/javase/javase8-archive-downloads.html)

Install Maven: [Link](https://maven.apache.org/install.html)

Install Docker: [Link](https://docs.docker.com/desktop/install/windows-install/)

## Installation

To install this web application make the following steps:

1. Create database mysql with docker
    + run below command to run mysql container
    + then run **resources/init.sql** to init database
  
`docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root --name mysql mysql:8.0`

  
2.  Clone project
   
`git clone https://github.com/tanthanh2002/management-app.git`

`cd management-app`

`mvn clean install`

3. Run project
   
Run embedded tomcat 7 with maven

`mvn tomcat7:run`

Open the URL following

 `http://localhost:8080/`

or

`http://localhost:8080/index`