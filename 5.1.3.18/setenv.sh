# Tomcat memory settings
# -Xms<size> set initial Java heap size
# -Xmx<size> set maximum Java heap size
# -Xss<size> set java thread stack size
# -XX:MaxPermSize sets the java PermGen size

# Default memory settings if not specified in $LUCEE_JAVA_OPTS
: ${LUCEE_JAVA_OPTS:="-Xms256m -Xmx512m"}

# Use /dev/urandom for EGD (http://wiki.apache.org/tomcat/HowTo/FasterStartUp)
JAVA_OPTS="${LUCEE_JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom -Dlucee-extensions=17AB52DE-B300-A94B-E058BD978511E39E,7E673D15-D87C-41A6-8B5F1956528C605F,1C9A7C34-2555-4AAA-92FBB7FC7111140C,66E312DD-D083-27C0-64189D16753FD6F0,E6634E1A-4CC5-4839-A83C67549ECA8D5B,CED6227E-0F49-6367-A68D21AACA6B07E8,16FF9B13-C595-4FA7-B87DED467B7E61A0,D46D49C3-EB85-8D97-30BEC2F38561E985";

# additional JVM arguments can be added to the above line as needed, such as
# custom Garbage Collection arguments.

export JAVA_OPTS;

# Add location of Apache Tomcat native library to the library path
LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu";
export LD_LIBRARY_PATH;
