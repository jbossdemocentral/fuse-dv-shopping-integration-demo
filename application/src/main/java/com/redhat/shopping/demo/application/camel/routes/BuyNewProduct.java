package com.redhat.shopping.demo.application.camel.routes;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.apache.camel.builder.RouteBuilder;

public class BuyNewProduct extends RouteBuilder {

	@Override
	public void configure() throws Exception {
		from("vm:buyProductsByCode")
		.log("Buy Request Started")
		.process(new Processor() {
			
			public void process(Exchange exchange) throws Exception {
				exchange.getIn().setHeader("awaitingResponse",
						true);				
			}
		})
		.setHeader("productCode",simple("${body[0]}"))
		.to("activemq:buyProductsByCode")
		.transform(constant("Thank you for buying the products"));
	}
	
	
	
	

}
