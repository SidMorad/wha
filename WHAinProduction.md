# Introduction #

WHA in production (Include build and different settings)


# Details #

## Part 1: Setup Tools ##

If you have permission to run Maven2 in production then is good to build project in production instead of transfer binary (war file).

In our case we have these tools installed :
  * Apache Maven 2.2.1
  * Sun jdk1.6.0\_17
  * Apache Tomcat 6.0.20
  * Subversion
Note: Server is Linux 2.6.18 (CentOS 5.4)

At the end you may have something like this in .bash\_profile :
```
export JAVA_HOME="$HOME/dev/SDKs/jdk1.6.0_17"
export MAVEN_HOME="$HOME/dev/Tools/apache-maven-2.2.1/"
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=512m"
export PATH=$PATH:$HOME/bin:$MAVEN_HOME/bin
```
## Part 2: Build by Maven2 ##
```
svn checkout http://wha.googlecode.com/svn/trunk/ wha
cd wha
edit pom.xml and src/main/resources/database.properties for Database settings
mvn -P prod clean package
unzip target/wha-version.war to webapps/ROOT folder of tomcat
```
Note: `-P prod` will use database settings in production and also will backup data to src/test/resources/export-data.xml

## Part 3: Continuous Integration with Hudson ##
coming soon ...