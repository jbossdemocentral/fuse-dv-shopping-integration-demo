package com.redhat.shopping.demo.application.camel.beans;

import org.apache.camel.Exchange;
import org.apache.camel.Message;
import org.apache.camel.Processor;
import org.apache.camel.component.cxf.common.message.CxfConstants;

public class RestRouteProcessor implements Processor {

	public void process(Exchange exchange) throws Exception {
		Message inMessage = exchange.getIn();
		String operationName = inMessage.getHeader(
				CxfConstants.OPERATION_NAME, String.class);
		exchange.getIn().setHeader("resourceMapping",
				"vm:" + operationName);
		exchange.getIn().setHeader("awaitingResponse", true);
	}
	
	
	public String slip(Exchange exchange) {
		if (exchange.getIn().getHeader("awaitingResponse", Boolean.class)) {
			exchange.getIn().setHeader("awaitingResponse", false);
			return exchange.getIn().getHeader("resourceMapping", String.class);
		}
		return null;
	}

}
