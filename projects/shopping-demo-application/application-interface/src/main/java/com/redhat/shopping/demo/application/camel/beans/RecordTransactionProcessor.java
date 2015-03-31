package com.redhat.shopping.demo.application.camel.beans;

import java.util.Date;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;

public class RecordTransactionProcessor implements Processor {

	public void process(Exchange exchange) throws Exception {
		int id = Integer.parseInt(exchange.getIn().getBody().toString().split("=")[1].split("\\}")[0])+1;
		exchange.getIn().setHeader("transactionId", id);
		exchange.getIn().setHeader("dateOfPurchase", new java.sql.Date(new Date().getTime()));
	}
}
