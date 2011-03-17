/*
 * Created on 17/03/2011 - 10:25:55 PM 
 */
package nl.hajari.wha.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.EmployeeConstants;

/**
 *
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>	
 */
public interface EmployeeConstantsService {
	
	List<EmployeeConstants> getEmployeeConstantsListFromRequest(HttpServletRequest request);
	
	boolean persistEmployeeConstantsListWithEmployee(List<EmployeeConstants> ecList, Employee employee);
}
