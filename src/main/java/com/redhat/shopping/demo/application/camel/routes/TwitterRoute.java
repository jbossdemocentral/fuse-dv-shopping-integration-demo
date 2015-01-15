package com.redhat.shopping.demo.application.camel.routes;

import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.twitter.TwitterComponent;
/**
 * A Camel route that tweets on the shopping application page
 * whenever a new product is added
 */
public class TwitterRoute extends RouteBuilder {
	
    private String consumerKey;
    private String consumerSecret;
    private String accessToken;
    private String accessTokenSecret;

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public String getAccessTokenSecret() {
        return accessTokenSecret;
    }

    public void setAccessTokenSecret(String accessTokenSecret) {
        this.accessTokenSecret = accessTokenSecret;
    }

    public String getConsumerKey() {
        return consumerKey;
    }

    public void setConsumerKey(String consumerKey) {
        this.consumerKey = consumerKey;
    }

    public String getConsumerSecret() {
        return consumerSecret;
    }

    public void setConsumerSecret(String consumerSecret) {
        this.consumerSecret = consumerSecret;
    }


	@Override
    public void configure() throws Exception {
		 // setup Twitter component
        TwitterComponent tc = getContext().getComponent("twitter", TwitterComponent.class);
        tc.setAccessToken(accessToken);
        tc.setAccessTokenSecret(accessTokenSecret);
        tc.setConsumerKey(consumerKey);
        tc.setConsumerSecret(consumerSecret);
		from("vm:productAdditionTweet")
			.convertBodyTo(String.class)
			.log("${body}")
    		.log("Tweeting the product information: ${body}")
    		.to("twitter://timeline/user");

    }
    

}