package com.redhat.shopping.demo.application.camel.routes;

import java.io.File;
import java.net.URI;
import java.util.List;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.apache.camel.builder.NoErrorHandlerBuilder;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.converter.jaxb.JaxbDataFormat;
import org.apache.log4j.Logger;

public class AddProductRoute extends RouteBuilder {
	
	private static final Logger LOGGER = Logger.getLogger(AddProductRoute.class);
	
	public void configure() {
		errorHandler(new NoErrorHandlerBuilder());
		JaxbDataFormat dataFormat = new JaxbDataFormat("com.redhat.shopping.demo.application.pojos.jpa");
		dataFormat.setPartClass("com.redhat.shopping.demo.application.pojos.jpa.Products");
		dataFormat.setPrettyPrint(true);
		
		from("cxf:bean:productAddition")
		.process(new Processor() {
			
			public void process(Exchange exchange) throws Exception {
				LOGGER.info("Enter process()");
				String urlPath = (String)exchange.getIn().getBody(List.class).get(0);
				if(urlPath!=null){
					exchange.getOut().setBody(new File(new URI(urlPath)));
				}else{
					exchange.getOut().setBody("File Path Is Null");
				}
				
				LOGGER.info("Exit process()");
			}
		})
		.split().xpath("/products-list/products").parallelProcessing()
		.log("${body}")
		  .to("activemq:queue:insertProductsFromQueue")
		;
		
		
	}
}
