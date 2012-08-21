package org.croteau.jmsproducer.web.controller;


import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.croteau.jmsproducer.QueueProducer;


@Controller
@RequestMapping("/produce")
public class QueueProducerController {
	
	@Autowired QueueProducer producer;
	
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	public String produceMessage(@RequestParam(required=true) String message){
			
		producer.produce("Producing", message);
		System.out.println("posted message : " + message);	
		return "{ mike : check }";
		
	}
	
		
}
