package com.redhat.shopping.demo.application.camel.rest;

import org.apache.camel.component.cxf.common.message.CxfConstants;
import org.apache.camel.test.blueprint.CamelBlueprintTestSupport;
import org.junit.Test;

// to use camel-test-blueprint, then extend the CamelBlueprintTestSupport class,
// and add your unit tests methods as shown below.
public class TestRestRoute extends CamelBlueprintTestSupport {

	private String[] operationNames = {"showProducts","buyProductsByCode","showPreviousTransactions"}; 
	
	
	// here we have regular JUnit @Test method
	@Test
	public void testRoute() throws Exception {
		for (int index = 0; index < operationNames.length; index++) {
			String operationName = operationNames[index];
			
			// set mock expectations
	        getMockEndpoint("mock:"+operationName).expectedMessageCount(1);
	        			
			template.sendBodyAndHeader("direct:restTest", "Testing Rest Service", CxfConstants.OPERATION_NAME, operationName);
			// assert mocks
			assertMockEndpointsSatisfied();
		}

	}

	// override this method, and return the location of our Blueprint XML file
	// to be used for testing
	@Override
	protected String getBlueprintDescriptor() {
		return "classpath:camel-testRestService.xml";
	}
	
	
	@Override
	public boolean isUseDebugger() {
		// must enable debugger
		return true;
	}
}