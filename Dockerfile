FROM gradle:7.1.0-jdk11 AS build
COPY . .
RUN ./gradlew clean build -x test

FROM openjdk:11-jdk-slim-sid
COPY build/libs/*.jar springsan.jar
EXPOSE 8443
ENTRYPOINT ["java","-jar","springsan.jar"]