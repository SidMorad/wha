package nl.hajari.wha.domain;

import java.util.List;

import junit.framework.Assert;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * This class include the test for Employee entity. 
 **/
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= "classpath:META-INF/spring/applicationContext.xml")
public class EmployeeTest {

	@Test
	public void testFindAllEmployees() {
		List<Employee> employees= Employee.findAllEmployees();
		Assert.assertEquals(3, employees.size());
	}
	
	@Test
	public void testFindEmployeesByArchivedTrue() {
		List<Employee> fEmployees= Employee.findEmployeesByArchived(true).getResultList();
		Assert.assertEquals(1, fEmployees.size());
	}
	
	@Test
	public void testFindAllActiveEmployees() {
		List<Employee> fEmployees= Employee.findAllActiveEmployees();
		Assert.assertEquals(2, fEmployees.size());
	}
	
}
