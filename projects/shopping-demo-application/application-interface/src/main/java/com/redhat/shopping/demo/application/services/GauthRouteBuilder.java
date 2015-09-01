package com.redhat.shopping.demo.application.services;

import java.net.URLEncoder;
import org.apache.camel.builder.RouteBuilder;

/**
 * Builds the OAuth-specific routes (implements the OAuth integration layer) of the demo application.
 */
public class GauthRouteBuilder extends RouteBuilder {
   
	
	@Override
    public void configure() throws Exception {
    	getContext().setTracing(true);
		String encodedScope = URLEncoder.encode(
//				"https://accounts.google.com/o/oauth2/auth", "UTF-8");
				"https://www.googleapis.com/admin/directory/v1/users", "UTF-8");
        from("ghttp:///authorize")
        	.recipientList(simple("gauth:authorize?callback="+"${header.callBackUrl}"+"&scope="+encodedScope));
        from("ghttp:///handler")
           .log("Inside Upgradation Process")
				.to("gauth:upgrade")
				.log("Upgraded tokens")
            .process(new TokenProcessor());
    }

}