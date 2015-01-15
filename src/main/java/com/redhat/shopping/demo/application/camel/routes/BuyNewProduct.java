package com.redhat.shopping.demo.application.camel.routes;

import org.apache.camel.builder.RouteBuilder;

public class BuyNewProduct extends RouteBuilder {

	@Override
	public void configure() throws Exception {
		from("vm:buyProductsByCode")
		.log("Buy Request Started")
		.inOut("bean:buyProductValidation?method=validateCreditProductAvailability")
		.choice()
		.when(simple("${header.validateCreditProductAvailability}"))
		.to("activemq:buyProductsByCode")
		.transform(constant("Thank you for buying the products"))
		.otherwise()
		.transform(constant("Not Enought Credit"));
		
	}

}
