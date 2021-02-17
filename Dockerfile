FROM maven:3.6.3-openjdk-8 AS builder
WORKDIR /usr/src/app
COPY . /usr/src/app
RUN mvn -f /usr/src/app/pom.xml -B -DskipTests clean package

FROM openjdk:8-jdk-alpine
COPY --from=builder /usr/src/app/target/*.jar /usr/app/app.jar
COPY --from=builder /usr/src/app/keystore.p12 /
EXPOSE 8080

RUN wget https://search.maven.org/remotecontent?filepath=co/elastic/apm/elastic-apm-agent/1.2.0/elastic-apm-agent-1.2.0.jar
CMD java -javaagent:/usr/app/elastic-apm-agent-1.2.0.jar \
     -Delastic.apm.service_name=future_backend \
     -Delastic.apm.server_url=http://ec2-34-232-6-130.compute-1.amazonaws.com:8200 \
     -Delastic.apm.application_packages=com.bliblifuturebackend.bliblimart \
     -jar /usr/app/app.jar
