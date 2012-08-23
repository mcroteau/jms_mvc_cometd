package org.croteau.jmssubscriber;

import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;

import javax.jms.Message;
import javax.jms.TextMessage;
import javax.jms.MessageListener;
import javax.jms.ObjectMessage;


import com.google.gson.Gson;
import java.util.Map;
import java.util.Date; 
import java.sql.Timestamp;

import org.croteau.jmssubscriber.cometd.BayeuxMessageService;
import org.croteau.jms.domain.Order;


public class TopicListener implements MessageListener {

  	private Logger logger = Logger.getLogger(TopicListener.class);
	
	
	private Gson gson;
	@Autowired BayeuxMessageService buyeuxService;
	
	
	public TopicListener(){
		System.out.println("\n\nInitializing TopicListener\n\n");
		gson = new Gson();
	}
	
	
  	@Override
  	public void onMessage(Message message) {
		try {
			
			TextMessage textMessage = (TextMessage) message;
			
			System.out.println("TopicListener : Received Message");
			System.out.println(message);
			
			String orderGson = textMessage.getText();				
			buyeuxService.pushMessage(orderGson);	
		
		} catch (Exception e) {
			logger.error(e);
		}
  	}
}