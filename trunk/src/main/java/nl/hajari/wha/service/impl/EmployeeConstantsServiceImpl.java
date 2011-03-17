/*
 * Created on 17/03/2011 - 10:26:38 PM 
 */
package nl.hajari.wha.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.EmployeeConstants;
import nl.hajari.wha.service.EmployeeConstantsService;

import org.springframework.stereotype.Service;

/**
 *
 *
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>	
 */
@Service
public class EmployeeConstantsServiceImpl extends AbstractService implements EmployeeConstantsService {

	public List<EmployeeConstants> getEmployeeConstantsListFromRequest(HttpServletRequest request) {
		List<EmployeeConstants> ecList = new ArrayList<EmployeeConstants>();
		String counter = request.getParameter("counter");
		logger.debug("Number of added employee constantses were : " + counter);
		int total = Integer.parseInt(counter);
		for (int i = 1; i < total; i++){
			try {
				String key = request.getParameter("key"+i);
				if (null != key && !key.isEmpty()) {
					EmployeeConstants ec = new EmployeeConstants(null, key, request.getParameter("value"+i));
					ecList.add(ec);
					logger.debug("Employee constants "+ i +" recived by key "+ ec.getKey() +" and value "+ ec.getValue());
				}
			} catch (Exception e){
				logger.debug("Something went wrong:"+ e.getMessage());
			}
		}
		return ecList;
	}
	
	public boolean persistEmployeeConstantsListWithEmployee(List<EmployeeConstants> ecList, Employee employee) {
		boolean result = false;
		for (EmployeeConstants employeeConstants : ecList) {
			employeeConstants.setEmployee(employee);
			employeeConstants.persist();
			result = true;
		}
		return result;
	}
	
}
