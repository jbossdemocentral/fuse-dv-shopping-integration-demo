
package com.redhat.shopping.demo.application.camel.rest;

import javax.ws.rs.Consumes;
import javax.ws.rs.CookieParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/shoppingApplication")
public class ShoppingHomeService {
	
	@GET
	@Path("/products")
	@Produces(MediaType.APPLICATION_JSON)
	public String showProducts(){
		return null;
	}
	
	
	@POST
	@Path("/products/add")
	@Consumes(MediaType.APPLICATION_XML)
	@Produces(MediaType.TEXT_PLAIN)
	public String addProducts(){
		return null;
	}
	

	@GET
	@Path("/products/{productCode}/buy")
	@Produces(MediaType.APPLICATION_JSON)
	public String buyProductsByCode(@PathParam("productCode") String productCode,@CookieParam("userDetails") String customerID){
		return null;
	}
	
	
}
