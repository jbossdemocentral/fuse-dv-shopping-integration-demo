package com.redhat.shopping.demo.application.camel.routes;

import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.apache.camel.ValidationException;
import org.apache.camel.builder.RouteBuilder;

public class BuyNewProduct extends RouteBuilder {

	@Override
	public void configure() throws Exception {
		onException(ValidationException.class).handled(true)
		.process(new Processor() {
			public void process(Exchange exchange) throws Exception {
				Response response = Response.serverError().status(Status.FORBIDDEN).entity("The user Details are missing").build();
				throw new WebApplicationException(response);
			}
		});
		
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