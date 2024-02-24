FROM openjdk:11 AS BUILD
RUN apt update -y && apt install maven -y 
COPY ./  vprofile-project/
RUN cd vprofile-project && mvn clean package 

FROM tomcat:9-jre11
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD /vprofile-project/target/vprofile-v2.war  /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
