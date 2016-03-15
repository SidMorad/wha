# Introduction #

This page shows needed steps for setup this project.


# Steps #

## 1. Get Source ##
### 1.1 SVN repository ###
more information is available in below URL <br />
http://code.google.com/p/wha/source/checkout

### 1.1.1 Get Source with Eclipse ###
there is an Eclipse Plugin for work with SVN similar to CVS : <br />
check below web address for more info :<br />
http://subclipse.tigris.org/servlets/ProjectProcess?pageID=p4wYuA

Install this plugin is quite easy add below URL in Eclipse3.2+ update manager <br />
http://subclipse.tigris.org/update_1.6.x
and click all packages for install from this update manager .


## 2. Maven Commands ##
[Maven](http://maven.apache.org/)-2.0.9+ is required for this project.<br />
And don't forget to run maven commands in root directory of project .<br />
### 2.1 mvn tomcat:run ###
After run `mvn tomcat:run` then you could check http://localhost:8080/wha in your web browser.

### 2.1 mvn eclipse:eclipse ###
`mvn eclipse:eclipse` for download all Javadocs and sources

## 3. Eclipse ##
I am using SpringSource Tool Suite(STS) Version: 2.0.2 , looks perfect IDE for this project ;-)
<br />update : I've update STS to 2.2.0 and my JDK to 1.6.0\_16 , every things looks better .
<br />and this is output of `mvn -v` command:<br />
```
Colorizing console...
Apache Maven 2.1.0 (r755702; 2009-03-19 06:10:27+1100)
Java version: 1.6.0_16
Java home: /opt/dev/SDKs/jdk1.6.0_16/jre
Default locale: en_AU, platform encoding: UTF-8
OS name: "linux" version: "2.6.24-25-generic" arch: "amd64" Family: "unix"
```