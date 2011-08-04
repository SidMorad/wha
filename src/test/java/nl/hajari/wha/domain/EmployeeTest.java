package nl.hajari.wha.domain;

import java.util.List;

import junit.framework.Assert;
import nl.hajari.wha.service.EmployeeService;
import nl.hajari.wha.service.impl.EmployeeServiceImpl;

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

	@Test
	public void testArchiveEmployeeSave() {
		EmployeeService employeeService= new EmployeeServiceImpl();
		Employee employee= Employee.findEmployee(1L);
		employeeService.archive(employee);
		Employee aEmployee= Employee.findEmployee(1L);
		Assert.assertEquals(true, aEmployee.isArchived());

		List<Timesheet> atimesheets= Timesheet.findTimesheetsByEmployee(aEmployee).getResultList();
		for (Timesheet timesheet : atimesheets) {
			Assert.assertEquals(true, timesheet.isArchived());
		}
		Assert.assertEquals(false, aEmployee.getUser().isEnabled());
		
	}
	
	@Test 
	public void testArchiveUndoEmployeeSave() {
		EmployeeService employeeService= new EmployeeServiceImpl();
		Employee employee= Employee.findEmployee(3L);
		employeeService.archiveUndo(employee);
		Employee aEmployee= Employee.findEmployee(3L);
		Assert.assertEquals(false, aEmployee.isArchived());
		Assert.assertEquals(true, aEmployee.getUser().isEnabled());
	}
	
}
