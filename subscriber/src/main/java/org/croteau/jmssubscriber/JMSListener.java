package org.croteau.jmssubscriber;

import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;

import org.apache.log4j.Logger;


public class JMSListener implements MessageListener {

	private Logger logger = Logger.getLogger(JMSListener.class);
	
	@Override
	public void onMessage(Message message) {
		try {
			
			if (message instanceof MapMessage) {
				
				MapMessage mapMessage = (MapMessage) message;
				String title = mapMessage.getString("title");
				//String type = mapMessage.getString("type");
				String messageContent = mapMessage.getString("message");
				System.out.println("title : " + title + "  message : " + messageContent);
				
			}
			
		} catch (Exception e) {
		  	logger.error(e);
		}
	}
}
