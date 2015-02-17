package com.redhat.shopping.demo.application.camel.routes;

import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.salesforce.SalesforceComponent;
import org.apache.camel.component.salesforce.SalesforceLoginConfig;
/**
 * A Camel route that updates on the shopping application salesforce page
 * whenever a new product is added
 */
public class SalesForceRoute extends RouteBuilder {
	
	private SalesforceLoginConfig loginConfig;


	@Override
    public void configure() throws Exception {
        SalesforceComponent sc = getContext().getComponent("salesforce", SalesforceComponent.class);
        loginConfig.setLoginUrl("https://login.salesforce.com/");
		sc.setLoginConfig(loginConfig);
        from("vm:salesforceUpdate")
		.processRef("salesForceProductProcessor")
		.log("Creating products with name ${body.name}...")
		.to("salesforce:upsertSObject?sObjectName=ProductsObject__c&amp;sObjectIdName=Name")
		.log("Done creating products with success=${body.success} and errors=${body.errors}");

    }


	public SalesforceLoginConfig getLoginConfig() {
		return loginConfig;
	}


	public void setLoginConfig(SalesforceLoginConfig loginConfig) {
		this.loginConfig = loginConfig;
	}
    

}