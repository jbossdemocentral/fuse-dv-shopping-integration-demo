package com.redhat.shopping.demo.application.camel.routes;

import java.net.URLEncoder;

import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.gae.auth.GAuthUpgradeBinding;

public class GauthRouteBuilder extends RouteBuilder {
	private String handlerLocation;
	private String consumerUrl; 
	private String authorizeUrl;

	@Override
	public void configure() throws Exception {
		getContext().setTracing(true);
		String encodedCallback = URLEncoder
				.encode(getHandlerLocationValidateIP(),
						"UTF-8");
		String encodedScope = URLEncoder.encode(
				"https://www.google.com/m8/feeds/", "UTF-8");
		from("jetty:"+getAuthorizeUrl()).to(
				"gauth:authorize?callback=" + encodedCallback + "&scope="
						+ encodedScope);
		from("jetty:"+getHandlerLocation())
				.log("Inside Upgradation Process")
				.to("gauth:upgrade")
				.log("Upgraded tokens")
				.to(consumerUrl+"?bridgeEndpoint=true&amp;throwExceptionOnFailure=false&accessToken="
						+ simple("${headers."
								+ GAuthUpgradeBinding.GAUTH_ACCESS_TOKEN + "}")
						+ "&accessTokenSecret="
						+ simple("${headers."
								+ GAuthUpgradeBinding.GAUTH_ACCESS_TOKEN_SECRET
								+ "}"));
	}


	private String getHandlerLocationValidateIP() {
		if(getHandlerLocation().contains("0.0.0.0")){
			return getHandlerLocation().replace("0.0.0.0", "localhost");
		}
		return getHandlerLocation();
	}


	public String getHandlerLocation() {
		return handlerLocation;
	}

	public void setHandlerLocation(String handlerLocation) {
		this.handlerLocation = handlerLocation;
	}

	public String getConsumerUrl() {
		return consumerUrl;
	}

	public void setConsumerUrl(String consumerUrl) {
		this.consumerUrl = consumerUrl;
	}

	public String getAuthorizeUrl() {
		return authorizeUrl;
	}

	public void setAuthorizeUrl(String authorizeUrl) {
		this.authorizeUrl = authorizeUrl;
	}

	
}