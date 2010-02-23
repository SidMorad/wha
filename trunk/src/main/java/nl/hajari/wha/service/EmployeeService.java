/*
 * Created on Feb 23, 2010 - 4:02:43 PM
 */
package nl.hajari.wha.service;

import nl.hajari.wha.domain.Employee;

import java.util.List;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public interface EmployeeService {

	/**
	 * @param role
	 * @return
	 */
	List<Employee> findEmployeeByRole(String role);

	/**
	 * 
	 */
	void sendMonthlyTimesheetUpdateNotification();

}
