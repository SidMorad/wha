package nl.hajari.wha.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

privileged aspect TimeController_TimesheetController {

	@RequestMapping(value = "/time/timesheet/daily", method = RequestMethod.GET)
	public String TimeController.listTimesheetDaily(ModelMap modelMap, HttpServletRequest request) {
		Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
		if (employeeId == null) {
			throw new IllegalArgumentException("Employee Id is required.");
		}
			
		//modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeIdAndCurrentYear(employeeId));
		modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeId(employeeId));
		modelMap.put("employee", Employee.findEmployee(employeeId));
		return "time/timesheet/daily/list";
	}

	@RequestMapping(value = "/time/timesheet/travel", method = RequestMethod.GET)
	public String TimeController.listTimesheetTravel(ModelMap modelMap, HttpServletRequest request) {
		Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
		if (employeeId == null) {
			throw new IllegalArgumentException("Employee Id is required.");
		}
		
		//modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeIdAndCurrentYear(employeeId));
		modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeId(employeeId));
		modelMap.put("employee", Employee.findEmployee(employeeId));
		return "time/timesheet/travel/list";
	}

	@RequestMapping(value = "/time/timesheet/expense", method = RequestMethod.GET)
	public String TimeController.listTimesheetExpense(ModelMap modelMap, HttpServletRequest request) {
		Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
		if (employeeId == null) {
			throw new IllegalArgumentException("Employee Id is required.");
		}
		
		//modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeIdAndCurrentYear(employeeId));
		modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeId(employeeId));
		modelMap.put("employee", Employee.findEmployee(employeeId));
		return "time/timesheet/expense/list";
	}

	@RequestMapping(value = "/time/timesheet/daily/{id}", method = RequestMethod.GET)
	public String TimeController.showTimesheetDaily(@PathVariable("id") Long id, HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		if (id == null) {
			throw new IllegalArgumentException("An Identifer is required");
		}
		authorizeAccessTimesheet(id, request, response);
		modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));
		return "time/timesheet/daily/show";
	}

	@RequestMapping(value = "/time/timesheet/travel/{id}", method = RequestMethod.GET)
	public String TimeController.showTimesheetTravel(@PathVariable("id") Long id, HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		if (id == null) {
			throw new IllegalArgumentException("An Identifer is required");
		}
		authorizeAccessTimesheet(id, request, response);
		modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));
		return "time/timesheet/travel/show";
	}

	@RequestMapping(value = "/time/timesheet/expense/{id}", method = RequestMethod.GET)
	public String TimeController.showTimesheetExpense(@PathVariable("id") Long id, HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		if (id == null) {
			throw new IllegalArgumentException("An Identifer is required");
		}
		authorizeAccessTimesheet(id, request, response);
		modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));
		return "time/timesheet/expense/show";
	}

}
