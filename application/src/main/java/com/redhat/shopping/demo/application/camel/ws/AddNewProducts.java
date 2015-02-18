package com.redhat.shopping.demo.application.camel.ws;

import javax.jws.WebService;

@WebService
public interface AddNewProducts {
	void addProduct(String productsData);
}
