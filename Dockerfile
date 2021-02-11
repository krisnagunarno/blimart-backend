FROM maven:3.6.3-openjdk-8 AS builder
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN mvn -f /usr/src/app/pom.xml -B -DskipTests clean package

FROM openjdk:8-jdk-alpine
COPY --from=builder /usr/src/app/target/*.jar /usr/app/app.jar
COPY --from=builder /usr/src/app/keystore.p12 /
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/app/app.jar"]
