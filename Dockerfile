FROM maven:3.9-eclipse-temurin-8 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src
COPY WebContent ./WebContent

RUN mvn clean package -DskipTests

FROM eclipse-temurin:8-jre

WORKDIR /app

COPY --from=build /app/target/TrainBook-1.0.0-SNAPSHOT.war app.war
COPY --from=build /app/target/dependency/webapp-runner.jar webapp-runner.jar

EXPOSE 10000

CMD ["sh", "-c", "java -jar webapp-runner.jar --port ${PORT:-10000} app.war"]