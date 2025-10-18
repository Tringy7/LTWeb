# 🏗️ Stage 1: Build ứng dụng với Maven và JDK 22
FROM maven:3.9.8-eclipse-temurin-22 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN mvn clean package -DskipTests

# 🚀 Stage 2: Chạy ứng dụng với JDK 22
FROM eclipse-temurin:22-jdk-jammy

WORKDIR /app

# Copy file .war từ stage build
COPY --from=build /app/target/*.war app.war

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.war"]
