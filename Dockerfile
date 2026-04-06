FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY app.java .
RUN javac app.java
CMD ["java", "app"]