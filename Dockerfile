# ---------- Build stage ----------
FROM maven:3.9.6-eclipse-temurin-17 AS builder

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# ---------- Run stage ----------
FROM openjdk-17-jre-headless

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]



# FROM ubuntu

# # Install the necessary packages
# RUN apt-get update && apt-get install -y
# RUN apt install openjdk-17-jre-headless -y
# RUN apt install maven -y

# # Set the working directory
# WORKDIR /app

# # Copy source files and pom.xml
# COPY ./src /app/src
# COPY ./pom.xml /app

# # Build the application
# RUN mvn -f /app/pom.xml clean package -DskipTests

# # Build target
# WORKDIR /app
# COPY --from=builder /app/target/*.jar app.jar

# # copy the build JAR file to the container
# #COPY ./target/*.jar /app/app.jar

# EXPOSE 8080

# ENTRYPOINT [ "java", "-jar", "app.jar" ]


#========================================
# FROM eclipse-temurin:25
# RUN mkdir /opt/app
# COPY japp.jar /opt/app
# CMD ["java", "-jar", "/opt/app/japp.jar"]
