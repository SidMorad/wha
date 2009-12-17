package nl.hajari.wha.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect TimeController_TimesheetController {

	@RequestMapping(value = "/time/timesheet", method = RequestMethod.GET)
	public String TimeController.listTimesheet(@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "size", required = false) Integer size, ModelMap modelMap, HttpServletRequest request) {
		Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
		if (page != null || size != null) {
			int sizeNo = size == null ? 10 : size.intValue();
			modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeId(employeeId, page == null ? 0
					: (page.intValue() - 1) * sizeNo, sizeNo));
			float nrOfPages = (float) Timesheet.countTimesheets() / sizeNo;
			modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1
					: nrOfPages));
		} else {
			modelMap.addAttribute("timesheets", Timesheet.findAllTimesheetsByEmployeeId(employeeId));
		}
		return "time/timesheet/list";
	}

	@RequestMapping(value = "/time/timesheet/{id}", method = RequestMethod.GET)
	public String TimeController.showTimesheet(@PathVariable("id") Long id, HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		if (id == null) {
			throw new IllegalArgumentException("An Identifer is required");
		}
		authorizeAccessTimesheet(id, request, response);
		modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));
		return "time/timesheet/show";
	}

}
