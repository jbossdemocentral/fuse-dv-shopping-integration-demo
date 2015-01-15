package com.redhat.shopping.demo.application.camel.ws;

import javax.jws.WebService;

@WebService
public interface AddNewProducts {
	String addProduct(String fileName);
}
