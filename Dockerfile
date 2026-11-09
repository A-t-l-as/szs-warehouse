FROM eclipse-temurin:21-jdk-jammy AS build-backend
ENV HOME=/usr/backend
RUN mkdir -p $HOME
WORKDIR $HOME
ADD ./backend $HOME
RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package

FROM build-backend AS run-backend
ARG JAR_FILE=/usr/backend/target/*.jar
COPY --from=build-backend $JAR_FILE /app/runner.jar
EXPOSE 8080
CMD ["java", "-jar", "/app/runner.jar"]
