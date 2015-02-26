package com.redhat.shopping.demo.application.services;


import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gdata.util.AuthenticationException;
import com.redhat.shopping.demo.application.beans.User;


@RequestMapping("/")
public class ApplicationController {

    @Autowired
    private TokenLoginService service;
    
    @RequestMapping(method = RequestMethod.GET,value={"buy"})
    public String handleBuy(HttpServletRequest request,Model model) throws Exception {
		String productCode = request.getParameter("productCode");
    	StringBuffer buyResult = fetchRestResponse("http://localhost:9090/route/shoppingApplication/products/"+productCode+"/buy");
		model.addAttribute("buyResult",buyResult.toString());
        return "/homePage.jsp";        
    }

    @RequestMapping(method = RequestMethod.GET,value={"authenticate"})
    public String handleAuthenticate(
            HttpServletRequest request, 
            HttpServletResponse response, 
            ModelMap model) throws Exception {
         model.put("message", "No OAuth access token available");
          return "/authorize.jsp";
        }
                
    
    
    @RequestMapping(method = RequestMethod.GET,value={"postAuthenticate"})
    public String handlePostAuthenticate(
            HttpServletRequest request, 
            HttpServletResponse response, 
            ModelMap model) throws Exception {
    	 User userDetails = null;
		try {
    	        userDetails = service.getContactNames(getAccessToken(request), getAccessTokenSecret(request));
    	    } catch (AuthenticationException e) {
    	        model.put("message", "OAuth access token invalid");
    	        return "/authorize.jsp";
    	    }
    	    request.getSession().setAttribute("userDetails", userDetails);
    	    return "/homePage.jsp";
       }
   
    @RequestMapping(method = RequestMethod.GET,value={"show"})
    public String handleShow(ModelMap model) throws Exception {
    	
    	StringBuffer showProducts = fetchRestResponse("http://localhost:9090/route/shoppingApplication/products/");
		model.addAttribute("showProducts",showProducts.toString());
        return "/homePage.jsp";               
    }

   
    
    private StringBuffer fetchRestResponse(String url)
			throws IOException, ClientProtocolException {
		HttpClient client = new DefaultHttpClient();
		HttpGet request = new HttpGet(url);
		HttpResponse response = client.execute(request);
		StringBuffer buyResult  = new StringBuffer(IOUtils.toString(response.getEntity().getContent()));
		return buyResult;
	}
    
    private static String getAccessToken(HttpServletRequest request) {
        return getCookieValue(request.getCookies(), "ACCESS-TOKEN");
    }
    
    private static String getAccessTokenSecret(HttpServletRequest request) {
        return getCookieValue(request.getCookies(), "ACCESS-TOKEN-SECRET");
    }
    
    private static String getCookieValue(Cookie[] cookies, String name) {
        if (cookies == null) {
            return null;
        }
        for (Cookie cookie : cookies) {
            if (name.equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return null;
    }

}