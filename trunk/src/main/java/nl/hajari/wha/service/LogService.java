/*
 * Created on Jan 30, 2010 - 6:13:10 PM
 */
package nl.hajari.wha.service;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.domain.User;

/**
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
public interface LogService {

	/**
	 * 
	 * @param username
	 * @param user
	 * @param employee
	 * @param timesheet
	 * @param details
	 */
	void log(String username, User user, Employee employee,
			Timesheet timesheet, String details);

	/**
	 * 
	 * @param timesheet
	 * @return true if succeed
	 */
	boolean deleteLogByTimesheet(Timesheet timesheet);
}
