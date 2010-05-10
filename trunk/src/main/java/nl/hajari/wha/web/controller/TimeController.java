package nl.hajari.wha.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.domain.User;
import nl.hajari.wha.service.DailyTravelService;
import nl.hajari.wha.service.impl.CustomerServiceImpl;
import nl.hajari.wha.service.impl.DailyExpenseServiceImpl;
import nl.hajari.wha.service.impl.DailyTimesheetServiceImpl;
import nl.hajari.wha.service.impl.ProjectServiceImpl;
import nl.hajari.wha.service.impl.TimesheetPossibleWeeksOptionsProvider;
import nl.hajari.wha.web.util.SecurityContextUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/time/**")
@Controller
public class TimeController extends AbstractController {

	protected static final String WORKING_DAILY_TIMESHEET_KEY = "WORKING_DAILY_TIMESHEET_KEY";

	@Autowired
	protected DailyTimesheetServiceImpl dailyTimesheetService;

	@Autowired
	protected DailyExpenseServiceImpl dailyExpenseService;
	
	@Autowired
	protected DailyTravelService dailyTravelService;
	
	@Autowired
	protected ProjectServiceImpl projectService;

	@Autowired
	protected CustomerServiceImpl customerService;

	@Autowired
	protected TimesheetPossibleWeeksOptionsProvider timesheetPossibleWeeksOptionsProvider;

	public boolean authorizeAccessTimesheet(Long id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Timesheet timesheet = Timesheet.findTimesheet(id);
		if (timesheet == null) {
			return true;
		}
		Long userId = timesheet.getEmployee().getUser().getId();
		User user = (User) User.findUsersByUsernameEquals(SecurityContextUtils.getCurrentUsername()).getSingleResult();
		if (user == null || !user.getId().equals(userId)) {
			String message = "Unauthorized access of user [" + user + "] to timesheet[" + timesheet + "] for employee["
					+ timesheet.getEmployee() + "]";
			logger.warn(message);
			// response.sendError(HttpServletResponse.SC_FORBIDDEN, message);
			throw new AccessDeniedException(message);
		}
		return true;
	}

	public String getFileFullPath(HttpServletRequest request, String filePath) {
		String appServerHome = request.getSession().getServletContext().getRealPath("/");
		return appServerHome + filePath;
	}

	protected Long getEmployeeId(HttpServletRequest request) {
		return (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
	}

	protected Long getTimesheetId(HttpServletRequest request) {
		return (Long) request.getSession().getAttribute(Timesheet.TIMESHEET_ID);
	}

	protected void prepareOrInitializeCommonTimesheetInformation(HttpServletRequest request, ModelMap modelMap) {
		Long employeeId = getEmployeeId(request);
		logger.debug("Employee on the session: " + employeeId);
		if (employeeId == null) {
			throw new IllegalStateException("Month time sheet view requires registered emplpee. Employee ID is null.");
		}
		Timesheet timesheet = (Timesheet) Timesheet.findEmployeeCurrentTimesheet(employeeId).getSingleResult();
		logger.debug("Employee Timesheet found: " + timesheet);
		modelMap.put("dailyTimesheets", timesheet.getDailyTimesheetsSortedList());
		modelMap.put("timesheet", timesheet);
		modelMap.put("employee", Employee.findEmployee(employeeId));
	}

	protected void prepareOrInitializeCommonTimesheetTravelsInformation(HttpServletRequest request, ModelMap modelMap) {
		Long employeeId = getEmployeeId(request);
		logger.debug("Employee on the session: " + employeeId);
		if (employeeId == null) {
			throw new IllegalStateException("Month time sheet view requires registered emplpee. Employee ID is null.");
		}
		Timesheet timesheet = (Timesheet) Timesheet.findEmployeeCurrentTimesheet(employeeId).getSingleResult();
		logger.debug("Employee Timesheet found: " + timesheet);
		modelMap.put("timesheet", timesheet);
		modelMap.put("dailyTravels", timesheet.getDailyTravelsSortedList());
		modelMap.put("employee", Employee.findEmployee(employeeId));
	}
	
}
