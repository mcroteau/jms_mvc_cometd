package org.croteau.jmssubscriber.listener;

import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;

import org.apache.log4j.Logger;


public class JMSListener implements MessageListener {

	private Logger logger = Logger.getLogger(FooListener.class);
	
	@Override
	public void onMessage(Message message) {
		try {
			
			if (message instanceof MapMessage) {
				
				MapMessage mapMessage = (MapMessage) message;
				String title = mapMessage.getString("title");
				//String type = mapMessage.getString("type");
				String message = mapMessage.getString("message");
				System.out.println("title : " + title + "  message : " + message);
				
			}
			
		} catch (Exception e) {
		  	logger.error(e);
		}
	}
}
