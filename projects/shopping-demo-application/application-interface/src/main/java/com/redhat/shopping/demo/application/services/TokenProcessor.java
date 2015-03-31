package com.redhat.shopping.demo.application.services;

import static org.apache.camel.component.gae.auth.GAuthUpgradeBinding.GAUTH_ACCESS_TOKEN;
import static org.apache.camel.component.gae.auth.GAuthUpgradeBinding.GAUTH_ACCESS_TOKEN_SECRET;

import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.apache.camel.Exchange;
import org.apache.camel.Processor;

public class TokenProcessor implements Processor {

    private static final int ONE_HOUR = 3600;
    
    public void process(Exchange exchange) throws Exception {
        String accessToken = exchange.getIn().getHeader(GAUTH_ACCESS_TOKEN, String.class);
        String accessTokenSecret = exchange.getIn().getHeader(GAUTH_ACCESS_TOKEN_SECRET, String.class);
        URL httpUrl = new URL(exchange.getIn().getHeader("CamelHttpUrl", String.class));
        String contextName = "/"+httpUrl.getPath().split("/")[1];
        if (accessToken != null) {
            HttpServletResponse servletResponse = exchange.getIn().getHeader(
                    Exchange.HTTP_SERVLET_RESPONSE, HttpServletResponse.class);
            
            Cookie accessTokenCookie = new Cookie("ACCESS-TOKEN", accessToken);
            Cookie accessTokenSecretCookie = new Cookie("ACCESS-TOKEN-SECRET", accessTokenSecret); 
            accessTokenCookie.setPath(contextName+"/");
            accessTokenCookie.setMaxAge(ONE_HOUR);
            
            accessTokenSecretCookie.setPath(contextName+"/");
            accessTokenSecretCookie.setMaxAge(ONE_HOUR);
            
            servletResponse.addCookie(accessTokenCookie);
            servletResponse.addCookie(accessTokenSecretCookie);
        }
        
        exchange.getOut().setHeader(Exchange.HTTP_RESPONSE_CODE, 302);
        exchange.getOut().setHeader("Location", contextName+"/application/postAuthenticate");
    }

}