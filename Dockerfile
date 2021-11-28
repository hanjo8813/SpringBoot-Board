FROM openjdk:17-jdk-alpine
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]

# docker build -t temp_img .
# docker run -d --name temp_con -p 8080:8080 -e "SPRING_PROFILES_ACTIVE=prod" -e "DB_URL=jdbc:mysql://devcourse.cxtvn8tlpabr.ap-northeast-2.rds.amazonaws.com/board_mission" -e "DB_USERNAME=root" -e "DB_PASSWORD=prgrms1234" temp_img


