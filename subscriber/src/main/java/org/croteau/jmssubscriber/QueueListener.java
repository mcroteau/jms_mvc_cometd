package org.croteau.jmssubscriber;

import org.apache.log4j.Logger;


import org.springframework.beans.factory.annotation.Autowired;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageListener;

import com.google.gson.Gson;
import java.util.Map;
import java.util.Date; 
import java.sql.Timestamp;

import org.croteau.jmssubscriber.cometd.BayeuxMessageService;
import org.croteau.jms.domain.Order;


public class QueueListener implements MessageListener {

	private Logger logger = Logger.getLogger(QueueListener.class);
	
	
	private Gson gson;
	@Autowired BayeuxMessageService buyeuxService;
	
	
	public QueueListener(){
		System.out.println("\n\nInitializing QueueListener\n\n");
		gson = new Gson();
	}	
	
	@Override
	public void onMessage(Message message) {
		try {
			
			System.out.println("QueueListener : Received Message");
			
			if (message instanceof MapMessage) {
				
				MapMessage mapMessage = (MapMessage) message;
				String timestamp = mapMessage.getString("timestamp");
				String orderGson = mapMessage.getString("orderGson");
			
				Order order = gson.fromJson(orderGson, Order.class);

				System.out.println("received order : " + orderGson);
				
				buyeuxService.pushMessage(orderGson);
				
			}
			
		} catch (Exception e) {
		  	logger.error(e);
		}
	}
}
