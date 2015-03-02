package com.redhat.shopping.demo.application.camel.routes;

import org.apache.camel.ValidationException;
import org.apache.camel.builder.RouteBuilder;

public class BuyNewProduct extends RouteBuilder {

	@Override
	public void configure() throws Exception {
		onException(ValidationException.class).handled(true)
		.transform().simple("The user details are missing in the request. Please clear your cookies and try again");
		from("vm:buyProductsByCode")
		.log("Buy Request Started")
		.log("${body}")
		.setHeader("productCode",simple("${body[0]}"))
		.validate().simple("${body[1]} != null")
		.setHeader("customerDetails",simple("${body[1]}"))
		.to("activemq:buyProductsByCode")
		.transform(constant("Thank you for buying the products"));
	}
}
