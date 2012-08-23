package org.croteau.jmsproducer;

import javax.jms.ConnectionFactory;
import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.Queue;
import javax.jms.Session;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;

import java.sql.Timestamp;

public class QueueProducer {

	private Logger logger = Logger.getLogger(QueueProducer.class);
	private JmsTemplate jmsTemplate;
	private Queue queue;
	
	public void produce(final String timestamp, final String orderGson) {
	    this.jmsTemplate.send(this.queue, new MessageCreator() {
	    	public Message createMessage(Session session) throws JMSException {
	    		MapMessage mm = session.createMapMessage();
	      		mm.setString("timestamp", timestamp);
	      		mm.setString("orderGson", orderGson);
	      		return mm;
	    	}
	 	});
		System.out.println("Message produced on queue");
	}
	
	
	@Required
	public void setConnectionFactory(ConnectionFactory connectionFactory) {
		this.jmsTemplate = new JmsTemplate(connectionFactory);
	}
	
	@Required
	public void setQueue(Queue queue) {
		this.queue = queue;
	}
	
}
