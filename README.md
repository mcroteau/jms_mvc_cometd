##Spring Web MVC, Spring JMS, ActiveMQ, CometD 

JMS Publish/Subscribe example applications using Spring Web MVC, JMS, ActiveMQ, CometD

###Producer App

Running the Producer App will allow you to publish a message on a test topic by browsing to http://localhost:8080/jms-producer/produce?message=message to send


###Subscriber App

The Subscriber App subscribes to the test topic that the producer app publishes to.  When a message is received, the message gets pushed to the client via comet (cometd).  The messages can be seen by browsing to http://localhost:8080/jms-subscriber/