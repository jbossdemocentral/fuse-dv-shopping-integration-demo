package com.redhat.shopping.demo.application.camel.routes;

import org.apache.camel.Exchange;
import org.apache.camel.Message;
import org.apache.camel.Processor;
import org.apache.camel.builder.NoErrorHandlerBuilder;
import org.apache.camel.builder.RouteBuilder;
import org.apache.camel.component.cxf.common.message.CxfConstants;

public class RestRoute extends RouteBuilder {

	private static final String CXF_RS_ENDPOINT_URI = "cxfrs:bean:rsServer";

	public void configure() {
		errorHandler(new NoErrorHandlerBuilder());
		getContext().setTracing(true);

		from(CXF_RS_ENDPOINT_URI)
				.process(new Processor() {
					public void process(Exchange exchange) throws Exception {
						Message inMessage = exchange.getIn();
						String operationName = inMessage.getHeader(
								CxfConstants.OPERATION_NAME, String.class);
						exchange.getIn().setHeader("resourceMapping",
								"vm:" + operationName);
						exchange.getIn().setHeader("awaitingResponse", true);
					}
				}).log("${header.resourceMapping}")
				.dynamicRouter(method(RestRoute.class, "slip"));
	}

	public String slip(Exchange exchange) {
		if (exchange.getIn().getHeader("awaitingResponse", Boolean.class)) {
			exchange.getIn().setHeader("awaitingResponse", false);
			return exchange.getIn().getHeader("resourceMapping", String.class);
		}
		return null;
	}

}
