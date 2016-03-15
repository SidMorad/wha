# Introduction #

Currently we are using STS (SpringSource Tool Suites) [version 2.3.0](http://www.springsource.com/products/sts) and this wiki is about how to use Mylyn with Google Code.


# Details #

These steps need to be done for get things working :

## Install Mylyn Connector: Web Templates (Advanced) ##

  1. Help -> Install New Software
  1. Click Add button and past this URL: http://download.eclipse.org/tools/mylyn/update/incubator
  1. Check Mylyn Incubator -> Mylyn Connector: Web Templates (Advanced)

## Add Task Repositoriy ##

  1. Window -> Show View -> Task Repositories
  1. Right click on view -> Add Task Repository -> Select 'Web Template(Advanced)'
  1. Select 'Eclipse Outliner(Google Code)' from Server combobox
  1. Change Server URL to http://code.google.com/p/wha/issues
  1. Enter Label, User ID and Password then click finish button.

## Add Query ##

  1. Window -> Show View -> Task List
  1. Right click on view -> Add Query -> Select Your Task Repository