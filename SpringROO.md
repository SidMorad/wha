# Introduction #

This page contains brief information about [Spring-roo](http://www.springsource.org/roo) in this project.<br />

# Details #
## 1.Spring-roo 1.0.0.RC2 {rev 329} ##

## 2.Commands History ##
```
mkdir wha
cd wha
roo
roo> project --topLevelPackage nl.hajari.wha
roo> persistence setup --provider HIBERNATE --database HYPERSONIC_PERSISTENT
roo> entity --name ~.domain.Employee
roo> field string firstname --notNull --sizeMin 2 --sizeMax 30
roo> field string lastname --notNull --sizeMin 2 --sizeMax 30
roo> field date birthday --type java.util.Date
roo> field string email --sizeMax 30
roo> test integration 
roo> controller scaffold ~.web.EmployeeController
roo> selenium test --controller ~.web.EmployeeController
roo> perform tests 
roo> quit
mvn tomcat:run
```
you could check project on http://localhost:8080/wha
<br />and is good to open another console and run selenium test
```
mvn selenium:selenese
```

## 3.Useful Resources ##
1.[Jump into Roo for extreme Java productivity](http://blog.springsource.com/2009/05/01/roo-part-1/)<br />
2.[Getting Started with Spring Roo](http://blog.springsource.com/2009/05/27/roo-part-2/) <br />
3.[Exploring Roo's Architecture](http://blog.springsource.com/2009/06/18/roo-part-3/)<br />

## 4.Others ##
1. Try this command in console ! ;-)
```
roo> version jaime
```