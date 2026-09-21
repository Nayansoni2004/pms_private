# Use official Apache Tomcat 9.0 image with JDK 17
FROM tomcat:9.0-jdk17

# Optimize JVM memory options for Render's container environment
ENV JAVA_OPTS="-Xms128m -Xmx384m -XX:+UseContainerSupport"

# Remove default Tomcat web applications
RUN rm -rf /usr/local/tomcat/webapps/*

# Set working directory to ROOT web application
WORKDIR /usr/local/tomcat/webapps/ROOT

# Copy project files into ROOT web application
COPY . /usr/local/tomcat/webapps/ROOT/

# Support both root path (/) and context path (/pms)
RUN ln -s /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/pms

# Recompile all Java source files to guarantee compatibility with container runtime
RUN mkdir -p WEB-INF/classes && \
    find WEB-INF/src -name "*.java" > /tmp/sources.txt && \
    javac -cp "WEB-INF/lib/*:/usr/local/tomcat/lib/*" -d WEB-INF/classes @/tmp/sources.txt && \
    rm -f /tmp/sources.txt

# Expose default Tomcat port
EXPOSE 8080

# Dynamically adjust port for Render ($PORT) if set, otherwise default to 8080
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/g\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
