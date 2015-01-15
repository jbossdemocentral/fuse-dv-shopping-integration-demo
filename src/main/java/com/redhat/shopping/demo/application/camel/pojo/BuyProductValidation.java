package com.redhat.shopping.demo.application.camel.pojo;

import org.apache.camel.Exchange;

public class BuyProductValidation {
public void validateCreditProductAvailability(Exchange exchange){
	exchange.getIn().setHeader("validateCreditProductAvailability", true);
}
}
