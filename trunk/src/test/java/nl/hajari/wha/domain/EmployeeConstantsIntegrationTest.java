package nl.hajari.wha.domain;

import junit.framework.Assert;
import nl.hajari.wha.service.impl.EmployeeConstantsServiceImpl;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.roo.addon.test.RooIntegrationTest;

@RooIntegrationTest(entity = EmployeeConstants.class)
public class EmployeeConstantsIntegrationTest {
	
	@Autowired
	private EmployeeConstantsServiceImpl employeeConstantsService;
	
    @Test
    public void testMarkerMethod() {
    }
    
    @Test
    public void testPersistOrUpdate() {
    	Employee employee = Employee.findEmployee(1L);
    	EmployeeConstants employeeConstants1 = new EmployeeConstants(employee, "key1", "11");
    	employeeConstants1 = employeeConstantsService.persistOrUpdate(employeeConstants1);
    	Assert.assertNotNull("Expected 'employeeConstants1' identifier to be no longer null", employeeConstants1.getId());
    	
    	// add duplicate 'employee' and 'key'
    	EmployeeConstants employeeConstants2 = new EmployeeConstants(employee, "key1", "22");
    	employeeConstants2 = employeeConstantsService.persistOrUpdate(employeeConstants2);
    	Assert.assertEquals("Expected 'employeeConstants2' identifer should be same as 'employeeConstants2'", employeeConstants1.getId(), employeeConstants2.getId());
    	Assert.assertEquals("Expected 'employeeConstants2' value should be updated", employeeConstants2.getValue(), "22");
    }
   
}
