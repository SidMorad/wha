#!/bin/sh

export WHA_SRC_DIR=~/dev/ws/wha
export CATALINA_HOME=~/webapps/wha_demo/tomcat-6.0.20/
cd $WHA_SRC_DIR
pwd
svn up
mvn -e -P prod clean package
echo "Package built ... deploying ..."
cd $CATALINA_HOME
pwd
./bin/shutdown.sh
killall java
cd $CATALINA_HOME/webapps/ROOT
rm -rf *
cp $WHA_SRC_DIR/target/wha-0.2.1-SNAPSHOT.war .
unzip wha-0.2.1-SNAPSHOT.war
rm -rf wha-0.2.1-SNAPSHOT.war
cd ../..
./bin/startup.sh
tailf logs/catalina.out
