# Stage 1: Build bằng Gradle
FROM gradle:8.5-jdk17-alpine AS build
WORKDIR /app
COPY . .
RUN ./gradlew bootJar -x test

# Stage 2: Chạy ứng dụng bằng JRE nhẹ
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8888
ENTRYPOINT ["java", "-jar", "app.jar"]