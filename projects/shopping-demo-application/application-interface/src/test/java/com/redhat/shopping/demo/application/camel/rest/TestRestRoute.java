package com.redhat.shopping.demo.application.camel.rest;

import org.apache.camel.CamelContext;
import org.apache.camel.ProducerTemplate;
import org.apache.camel.component.cxf.common.message.CxfConstants;
import org.apache.camel.component.mock.MockEndpoint;
import org.apache.camel.impl.DefaultProducerTemplate;
import org.apache.camel.test.spring.CamelSpringJUnit4ClassRunner;
import org.apache.camel.test.spring.DisableJmx;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.DirtiesContext;
import org.springframework.test.annotation.DirtiesContext.ClassMode;
import org.springframework.test.context.ContextConfiguration;

@RunWith(CamelSpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:camel-testRestContext.xml")
@DirtiesContext(classMode = ClassMode.AFTER_EACH_TEST_METHOD)
@DisableJmx(false)
public class TestRestRoute {

	private String[] operationNames = {"showProducts","buyProductsByCode","showPreviousTransactions"}; 
	
	@Autowired
	private CamelContext camelRestContext;
	
	private ProducerTemplate template;

	@Before
	public void init() throws Exception{
		template= new DefaultProducerTemplate(camelRestContext);
		template.start();
	}
	
	@After
	public void destroy() throws Exception{
		template.stop();
	}

	
	@Test
	public void testRoute() throws Exception {
		for (int index = 0; index < operationNames.length; index++) {
			String operationName = operationNames[index];
		    MockEndpoint mockEndpoint = new MockEndpoint();
			mockEndpoint.setEndpointUriIfNotSpecified("mock:"+operationName);
			mockEndpoint.setExpectedMessageCount(1);
			template.sendBodyAndHeader("direct:restTest", "Testing Rest Service", CxfConstants.OPERATION_NAME, operationName);
			MockEndpoint.assertIsSatisfied(camelRestContext);;
		}

	}
}