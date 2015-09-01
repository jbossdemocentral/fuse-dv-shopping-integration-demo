
package com.redhat.shopping.demo.application.camel.rest;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

@Path("/shoppingApplication")
public class ShoppingHomeService {
	
	@GET
	@Path("/products")
	@Produces(MediaType.APPLICATION_JSON)
	public String showProducts(){
		return null;
	}
	
	

	@GET
	@Path("/products/{productCode}/buy")
	@Produces(MediaType.APPLICATION_JSON)
	public String buyProductsByCode( @PathParam("productCode") String productCode,
			                         @QueryParam("customerDetails") String customerDetails){
		return null;
	}
	
	@GET
	@Path("/showTransactions")
	@Produces(MediaType.APPLICATION_JSON)
	public String showPreviousTransactions(@QueryParam("customerDetails") String customerDetails){
		return null;
	}
	
	
}
