package org.croteau.jmsproducer.web.controller;


import org.apache.log4j.Logger;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.croteau.jmsproducer.TopicPublisher;


@Controller
@RequestMapping("/publish")
public class TopicPublisherController {
	
	@Autowired TopicPublisher publisher;
	
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	public String publishMessage(@RequestParam(required=true) String message){
			
		publisher.publish("Publishing ", message);
		System.out.println("published message : " + message);	
		return "{ mike : check }";
		
	}
	
		
}
