package com.redhat.shopping.demo.application.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.redhat.shopping.demo.application.beans.TokenLoginService;

public class SetUserDetails extends HttpServlet {

	
	private static final int ONE_HOUR = 3600;


	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String accessToken = request.getParameter("accessToken");
		String accessTokenSecret = request.getParameter("accessTokenSecret");
		List<String> userContacts = null;
		Cookie accessTokenCookie = new Cookie("ACCESS-TOKEN", accessToken);
        Cookie accessTokenSecretCookie = new Cookie("ACCESS-TOKEN-SECRET", accessTokenSecret); 
        accessTokenCookie.setPath("/oauth/");
        accessTokenCookie.setMaxAge(ONE_HOUR);
        accessTokenSecretCookie.setPath("/oauth/");
        accessTokenSecretCookie.setMaxAge(ONE_HOUR);
        response.addCookie(accessTokenCookie);
        response.addCookie(accessTokenSecretCookie);
		try {
		 userContacts = new TokenLoginService().getContactNames(accessToken, accessTokenSecret);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//Once Retrieved the userContacts can be saved in a file or database
		
		request.getSession().setAttribute("displayAuthentication", false);
		response.sendRedirect("/shoppingApplication");
		
		}

	
	public static void main(String[] args) {
		
		
	}
}
