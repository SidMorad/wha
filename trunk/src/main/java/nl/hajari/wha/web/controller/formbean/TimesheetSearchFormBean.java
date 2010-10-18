/*
 * Created on 14/10/2010 - 3:11:47 PM 
 */
package nl.hajari.wha.web.controller.formbean;

import java.util.Date;

import javax.validation.constraints.NotNull;

import nl.hajari.wha.domain.Employee;

/**
 * This class is 'form backing bean' for searching timesheets 
 * base on Employee, Start and End dates. 
 *
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>	
 */
public class TimesheetSearchFormBean {

	@NotNull
	private Employee employee;
	
	@NotNull
	private Date from;
	
	@NotNull
	private Date to;

	public TimesheetSearchFormBean() {}
	
	public TimesheetSearchFormBean(Employee employee, Date from, Date to) {
		this.employee = employee;
		this.from = from;
		this.to = to;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Date getFrom() {
		return from;
	}

	public void setFrom(Date from) {
		this.from = from;
	}

	public Date getTo() {
		return to;
	}

	public void setTo(Date to) {
		this.to = to;
	}
	
}
