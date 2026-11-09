FROM eclipse-temurin:21-jdk-jammy AS build
ENV HOME=/usr/backend
RUN mkdir -p $HOME
WORKDIR $HOME
ADD ./backend $HOME
RUN --mount=type=cache,target=/root/.m2 ./mvnw -f $HOME/pom.xml clean package

FROM eclipse-temurin:21-jdk-jammy
ARG JAR_FILE=/usr/backend/target/*.jar
COPY --from=build $JAR_FILE /app/runner.jar
EXPOSE 8080
ENTRYPOINT java -jar /app/runner.jar
