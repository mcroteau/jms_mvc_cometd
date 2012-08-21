package org.croteau.jmsproducer;

import javax.jms.ConnectionFactory;
import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.ObjectMessage;
import javax.jms.Queue;
import javax.jms.Session;
import javax.jms.Topic;

import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;


public class TopicPublisher {

	private Logger logger = Logger.getLogger(TopicPublisher.class);
	private JmsTemplate jmsTemplate;
	private Topic topic;

/**
	public void produce(final Object object) {
		this.jmsTemplate.send(this.topic, new MessageCreator() {
	    	public Message createMessage(Session session) throws JMSException {
	    		ObjectMessage mm = session.createObjectMessage();
	      		mm.setObject(object);
	      		return mm;
	    	}
	  	});
	}
**/
	

	public void publish(final String title, final String message) {
	    this.jmsTemplate.send(this.topic, new MessageCreator() {
	    	public Message createMessage(Session session) throws JMSException {
	    		MapMessage mm = session.createMapMessage();
	      		mm.setString("title", title);
	      		mm.setString("message", message);
	      		return mm;
	    	}
	 	});
	 	logger.info("Message sent to message broker");
	}
	
	
	@Required
	public void setConnectionFactory(ConnectionFactory connectionFactory) {
	  this.jmsTemplate = new JmsTemplate(connectionFactory);
	}
	
	@Required
	public void setTopic(Topic topic) {
	  this.topic = topic;
	}
}