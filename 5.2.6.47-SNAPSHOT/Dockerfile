FROM tomcat:8.0.48-jre8

MAINTAINER Eddie Ballisty, eddie.ballisty@blueriver.com

ENV LUCEE_JARS_URL http://release.lucee.org/rest/update/provider/loader/5.2.6.47-SNAPSHOT
ENV LUCEE_JAVA_OPTS "-Xms512m -Xmx512m"

ENV LUCEE_EXTENSIONS "1C9A7C34-2555-4AAA-92FBB7FC7111140C;Name=LogAnalyzer;version=2.3.1.16,16FF9B13-C595-4FA7-B87DED467B7E61A0;Name=Memcached;version=3.0.2.29,E6634E1A-4CC5-4839-A83C67549ECA8D5B;Name=MongoDB;version=3.4.2.59,D4EDFDBD-A9A3-E9AF-597322D767E0C949;Name=Oracle;version=12.1.0.2,17AB52DE-B300-A94B-E058BD978511E39E;Name=s3;version=0.9.4.116,EFDEB172-F52E-4D84-9CD1A1F561B3DFC8;Name=Lucene;version=2.4.1.30"

# Download core JAR, and delete it in one step to avoid committing the installer in a FS layer
RUN wget -nv $LUCEE_JARS_URL -O /root/lucee.jar && \
	mkdir -p /usr/local/tomcat/lucee && \
	cp /root/lucee.jar /usr/local/tomcat/lucee/lucee.jar && \
	rm -rf /root/lucee.jar

# Delete the default Tomcat webapps so they aren't deployed at startup
RUN rm -rf /usr/local/tomcat/webapps/*

# Set Tomcat config to load Lucee
COPY catalina.properties server.xml web.xml /usr/local/tomcat/conf/

# Custom setenv.sh to load Lucee
COPY setenv.sh /usr/local/tomcat/bin/
RUN chmod a+x /usr/local/tomcat/bin/setenv.sh

# Create Lucee configs
COPY lucee-server.xml /opt/lucee/server/lucee-server/context/lucee-server.xml
COPY lucee-web.xml.cfm /opt/lucee/web/lucee-web.xml.cfm

# urlrewrite
COPY urlrewritefilter-4.0.3.jar /usr/local/tomcat/lib/

# Provide test page
RUN mkdir -p /var/www
COPY index.cfm /var/www/
ONBUILD RUN rm -rf /var/www/*

# lucee first time startup; explodes lucee and installs bundles/extensions (prewarms twice due to additional bundle downloads)
COPY prewarm.sh /usr/local/tomcat/bin/
RUN chmod +x /usr/local/tomcat/bin/prewarm.sh
RUN /usr/local/tomcat/bin/prewarm.sh && /usr/local/tomcat/bin/prewarm.sh

# Replace the Trusted SSL Certificates packaged with Lucee with those from Debian
#   ca-certificates package from the OS is the most recent authority
RUN cp -f /etc/ssl/certs/java/cacerts /opt/lucee/server/lucee-server/context/security/cacerts
