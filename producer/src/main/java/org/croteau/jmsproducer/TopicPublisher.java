package org.croteau.jmsproducer;

import javax.jms.ConnectionFactory;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.ObjectMessage;
import javax.jms.Session;
import javax.jms.Topic;

import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;

import javax.jms.MessageProducer;



public class TopicPublisher {

	private Logger logger = Logger.getLogger(TopicPublisher.class);
	private JmsTemplate jmsTemplate;
	private Topic topic;


	public void publish(String orderGson) {		
		this.jmsTemplate.convertAndSend(this.topic, orderGson);
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