##Sample JMS App

Technologies : 
--------------
1. Spring Web MVC
2. Spring JMS
3. ActiveMQ
4. CometD


JMS Publish/Subscribe example applications using Spring Web MVC, JMS, ActiveMQ, CometD


###Contents

+ **main app** - a simple web project, runnable via jetty using the maven jetty plugin
+ **common** - a simple mock order pojo
+ **publisher** - a spring web mvc, jms app that publishes orders on a queue and a topic
+ **subscriber** - a spring web mvc, jms & cometd app that receives jms orders, deserializes and pushes to client via cometd
+ **web-common** - empty java project that contains common web artifacts : javascript, css libraries 


##Running the app

from the top level `jms_mvc_cometd` folder build the project

```
$  mvn clean install
```

run jetty

```
$  mvn jetty:run
```


browse to 

```
http://localhost:8080/
```

