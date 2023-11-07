#FROM gradle:7.1.0-jdk11 AS build
#COPY . .
#RUN ./gradlew clean build -x test
#
#FROM openjdk:11-jdk-slim-sid
#COPY build/libs/*.jar springsan.jar
#ENTRYPOINT ["java","-jar","springsan.jar"]

#FROM ubuntu:latest AS Build
#RUN apt-get update
#RUN apt-get-install openjdk-11-jdk-y
#COPY . .
#RUN ./gradlew bootJar --no-daemon
#
#FROM openjdk:11-jdk-slim-sid
#EXPOSE 8080
#COPY --from=build /build/libs/
#springsan.jar springsan.jar app.jar/
#ENTRYPOINT ["java","-jar","app.jar"]

FROM ubuntu:latest AS build

RUN apt-get update
RUN apt-get install openjdk-11-jdk -y
COPY . .

RUN ./gradlew bootJar --no-daemon

FROM openjdk:11-jdk-slim

EXPOSE 8080

COPY --from=build /build/libs/springsan.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]