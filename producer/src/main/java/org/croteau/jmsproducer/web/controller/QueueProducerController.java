package org.croteau.jmsproducer.web.controller;


import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestBody;

import com.google.gson.Gson;
import java.util.Map;
import java.util.Date; 
import java.sql.Timestamp;

import org.croteau.jmsproducer.QueueProducer;
import org.croteau.jms.domain.Order;


@Controller
public class QueueProducerController {
	
	@Autowired QueueProducer producer;
	
	private Gson gson;
	
	public QueueProducerController(){
		System.out.println("\n\nInitializing QueueProducerController\n\n");
		gson = new Gson();
	}
		

	@RequestMapping(value="/produce", method=RequestMethod.POST, consumes="application/json")
	public @ResponseBody String produceMessage(@RequestBody String orderJSON){
			
		Order order = gson.fromJson(orderJSON, Order.class);			
		Date date= new Date();	
		
		String orderGson = gson.toJson(order);//just checking to make sure serializes
		System.out.println("placed order : " + orderGson);	
		
		producer.produce(new Timestamp(date.getTime()).toString(), orderGson);	
		
		return orderGson;		
	}
	
		
}
