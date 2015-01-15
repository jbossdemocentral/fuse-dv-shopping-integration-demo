package com.redhat.shopping.demo.application.camel.routes;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.List;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.apache.camel.builder.NoErrorHandlerBuilder;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.converter.jaxb.JaxbDataFormat;
import org.apache.commons.io.IOUtils;

public class AddProductRoute extends RouteBuilder {
	public void configure() {
		errorHandler(new NoErrorHandlerBuilder());
		JaxbDataFormat dataFormat = new JaxbDataFormat("com.redhat.shopping.demo.application.pojos.jpa");
		dataFormat.setPartClass("com.redhat.shopping.demo.application.pojos.jpa.Products");
		dataFormat.setPrettyPrint(true);
		
		from("cxf:bean:productAddition")
		.process(new Processor() {
			
			@Override
			public void process(Exchange exchange) throws Exception {
				String filePath = (String)exchange.getIn().getBody(List.class).get(0);
				System.out.println("FilePath = "+filePath);
				if(filePath!=null){
					IOUtils.copy(new FileInputStream(new File(filePath)),new FileOutputStream(new File("C:/Users/vivekbalokhra/Documents/GitHub/shopping-demo-application/data/datafile/add_products.xml")));
				}else{
				exchange.getIn().setBody("File Path Is Null");
				}
				
				
			}
		});
		
		
		from("file:C:/Users/vivekbalokhra/Documents/GitHub/shopping-demo-application/data/datafile")
		.log("File-data = ${body}")
		.split().xpath("/products-list/products").parallelProcessing()
		.to("activemq:queue:insertProductsFromQueue")
		.transform().constant("Your Request Is Being Processed");
		
		
	}
}
