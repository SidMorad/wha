package nl.hajari.wha.web.security;

import java.io.IOException;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.domain.User;
import nl.hajari.wha.service.impl.LogServiceImpl;
import nl.hajari.wha.web.util.DateUtils;
import nl.hajari.wha.web.util.SecurityContextUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.filter.OncePerRequestFilter;

public class UserEmployeeSecurityFilter extends OncePerRequestFilter {

	@Autowired
	LogServiceImpl logService;
	
	@Override
	@Transactional
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		if (session.getAttribute(Employee.EMPLOYEE_ID) != null) {
			filterChain.doFilter(request, response);
			return;
		}
		String username = SecurityContextUtils.getCurrentUsername();
		if (!StringUtils.hasText(username)) {
			username = (String) session.getAttribute(User.USERNAME);
		}
		if (!StringUtils.hasText(username)) {
			filterChain.doFilter(request, response);
			return;
		}
		User currentUser = (User) User.findUsersByUsernameEquals(username).getSingleResult();
		if (currentUser == null) {
			filterChain.doFilter(request, response);
			return;
		}
		session.setAttribute(User.USERNAME, currentUser.getUsername());
		Employee currentEmployee = new Employee();
		try {
			currentEmployee = (Employee) Employee.findEmployeesByUser(currentUser).getSingleResult();
			if (currentEmployee != null) {
				session.setAttribute(Employee.EMPLOYEE_ID, currentEmployee.getId());
			}
			logger.debug("Registered current user[" + currentUser + "] and employe[" + currentEmployee
					+ "] on HTTP session.");
		} catch (Exception e) {
			filterChain.doFilter(request, response);
			return;
		}
		
		// Check if Timesheet entity exist, if not create one
		Timesheet timesheet = new Timesheet();
		int sheetYear = DateUtils.getCurrentYear();
		int sheetMonth = DateUtils.getCurrentMonth();
		try {
			timesheet = (Timesheet) Timesheet.findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals(currentEmployee, sheetMonth, sheetYear).getSingleResult();
		} catch (DataAccessException dae) {
			logger.debug("Looks like there is no timesheet for this employee[" + currentEmployee + "] , " +
					"let's create one for [" + sheetYear + " / " + sheetMonth + "]");
			// if timesheet doesn't exist make one. 
			timesheet.setSheetYear(sheetYear);
			timesheet.setSheetMonth(sheetMonth);
			timesheet.setEmployee(currentEmployee);
			timesheet.setMonthlyTotal(0f);
			timesheet.persist();
			logService.log(username, currentUser, currentEmployee,timesheet, "New Timesheet created for current Employee.");
		}
		session.setAttribute(Timesheet.TIMESHEET_ID, timesheet.getId());
		
		filterChain.doFilter(request, response);
	}
}
