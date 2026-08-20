FROM tomcat:10.1-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY readcart.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 3000
CMD ["catalina.sh", "run"]
