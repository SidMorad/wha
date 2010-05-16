#!/bin/sh

export WHA_SRC_DIR=~/dev/ws/wha
cd $WHA_SRC_DIR
pwd
svn up
mvn -e -P prod clean package
cd ~/webapps/wha_demo/tomcat-6.0.20/
pwd
./bin/shutdown.sh
cd webapps/ROOT
cp $WHA_SRC_DIR/target/wha*.war .
unzip wha-0.2.1-SNAPSHOT.war
rm -rf wha-0.2.1-SNAPSHOT.war
cd ../..
./bin/startup.sh
tailf logs/catalina.out

