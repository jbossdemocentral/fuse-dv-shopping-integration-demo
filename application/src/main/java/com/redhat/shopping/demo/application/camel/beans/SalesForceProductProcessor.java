package com.redhat.shopping.demo.application.camel.beans;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;
import org.apache.camel.salesforce.dto.ProductsObject__c;

import com.redhat.shopping.demo.application.pojos.jpa.Products;

public class SalesForceProductProcessor implements Processor {

	public void process(Exchange exchange) throws Exception {
		ProductsObject__c object__c  =new ProductsObject__c();
		Products product = exchange.getIn().getBody(Products.class);
		object__c.setProductItemName__c(product.getProductName());
		object__c.setProductItemPrice__c(product.getBuyPrice().doubleValue());
		object__c.setName(product.getProductName());
		exchange.getIn().setBody(object__c, ProductsObject__c.class);
	}

}
