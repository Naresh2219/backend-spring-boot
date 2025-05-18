# Stage 1: Build
FROM maven:3.9.3-amazoncorretto-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean install -DskipTests

# Stage 2: Run
FROM openjdk:17
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
