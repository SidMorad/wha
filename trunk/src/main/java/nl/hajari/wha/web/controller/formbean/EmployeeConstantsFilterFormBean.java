/*
 * Created on 28/02/2011 - 2:50:20 AM 
 */
package nl.hajari.wha.web.controller.formbean;

import javax.validation.constraints.NotNull;
import nl.hajari.wha.domain.Employee;

/**
 * 
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
public class EmployeeConstantsFilterFormBean {

	public EmployeeConstantsFilterFormBean() {}
	
	@NotNull
	private Employee employee;

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

}
