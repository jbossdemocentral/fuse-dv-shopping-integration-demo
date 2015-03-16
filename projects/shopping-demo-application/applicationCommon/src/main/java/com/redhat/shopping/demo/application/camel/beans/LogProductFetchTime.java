package com.redhat.shopping.demo.application.camel.beans;

import java.util.Date;

import org.apache.camel.Exchange;
import org.apache.log4j.Logger;

public class LogProductFetchTime {
	Logger log = Logger.getLogger(LogProductFetchTime.class);
public void logQueryTimeAfter(){
	log.warn("After time ="+new Date().getTime());
}
public void logQueryTimeBefore(){
	log.warn("Before time ="+new Date().getTime());
}
public void logQueryTimeFinally(Exchange exchange){
	log.warn("Aop over product addition query ended");
}
}
