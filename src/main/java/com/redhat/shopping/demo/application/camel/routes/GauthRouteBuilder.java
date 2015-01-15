package com.redhat.shopping.demo.application.camel.routes;

import java.net.URLEncoder;

import org.apache.camel.builder.RouteBuilder;

public class GauthRouteBuilder extends RouteBuilder {

	@Override
	public void configure() throws Exception {
		getContext().setTracing(true);
		
		
		// Calback URL to redirect user from Google Authorization back to the web application
        String encodedCallback = URLEncoder.encode("https://localhost:8443/handler", "UTF-8");
        // Application will request for authorization to access a user's Google Calendar
        String encodedScope = URLEncoder.encode("http://www.google.com/calendar/feeds/", "UTF-8");

        // Route 1: A GET request to http://localhost/authorize will trigger the the OAuth
        // sequence of interactions. The gauth:authorize endpoint obtains an unauthorized request
        // token from Google and then redirects the user (browser) to a Google authorization page.
        from("jetty:http://0.0.0.0:8080/authorize")
            .to("gauth:authorize?callback=" + encodedCallback + "&scope=" + encodedScope);

        // Route 2: Handle callback from Google. After the user granted access to Google Calendar
        // Google redirects the user to https://localhost:8443/handler (see callback) along
        // with an authorized request token. The gauth:access endpoint exchanges the authorized
        // request token against a long-lived access token.
        from("jetty:https://0.0.0.0:8443/handler")
        	.to("gauth:upgrade")
            .log("Google Access Token =  ${header.CamelGauthAccessToken}")
            .log("Google Access Token Secret =  ${header.CamelGauthAccessTokenSecret}");
            // The access token can be obtained from
            // exchange.getOut().getHeader(GAuthUpgradeBinding.GAUTH_ACCESS_TOKEN)
            // The access token secret can be obtained from
            // exchange.getOut().getHeader(GAuthUpgradeBinding.GAUTH_ACCESS_TOKEN_SECRET)
	}
}