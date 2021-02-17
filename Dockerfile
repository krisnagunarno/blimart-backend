FROM maven:3.6.3-openjdk-8 AS builder
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN mvn -f /usr/src/app/pom.xml -B -DskipTests clean package

FROM openjdk:8-jdk-alpine
COPY --from=builder /usr/src/app/target/*.jar /usr/app/app.jar
COPY --from=builder /usr/src/app/keystore.p12 /
EXPOSE 8080

RUN wget https://raw.githubusercontent.com/heronimus/guide-apm-monitoring/master/microservices/src-elastic-apm/elastic-apm-agent-1.16.1-WEBFLUX.jar -O /usr/app/elastic-apm-agent-1.2.0.jar
CMD ["java","-javaagent:/usr/app/elastic-apm-agent-1.2.0.jar","-Delastic.apm.service_name=future_backend","-Delastic.apm.server_url=https://apm.kucik.my.id","-Delastic.apm.application_packages=com.bliblifuturebackend.bliblimart","-jar","/usr/app/app.jar"]
