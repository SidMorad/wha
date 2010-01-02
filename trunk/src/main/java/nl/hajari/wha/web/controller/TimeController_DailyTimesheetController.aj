package nl.hajari.wha.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.web.util.DateUtils;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

privileged aspect TimeController_DailyTimesheetController {

	@RequestMapping(value = "/time/view/month", method = RequestMethod.GET)
	public String TimeController.prepareTimesheetMonthView(HttpServletRequest request, ModelMap modelMap) {
		Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
		logger.debug("Employee on the session: " + employeeId);
		if (employeeId == null) {
			throw new IllegalStateException("Month time sheet view requires registered emplpee. Employee ID is null.");
		}
		Timesheet timesheet = (Timesheet) Timesheet.findEmployeeCurrentTimesheet(employeeId).getSingleResult();
		logger.debug("Employee Timesheet found: " + timesheet);
		List<DailyTimesheet> dailyTimesheets = timesheet.getDailyTimesheetsSortedList();

		DailyTimesheet dailyTimesheet = new DailyTimesheet();
		dailyTimesheet.setDurationOffs(0f);
		dailyTimesheet.setDurationTraining(0f);
		if (modelMap.containsAttribute(WORKING_DAILY_TIMESHEET_KEY)) {
			DailyTimesheet current = (DailyTimesheet) modelMap.get(WORKING_DAILY_TIMESHEET_KEY);
			dailyTimesheet.setDayDate(current.getDayDate());
			dailyTimesheet.setProject(current.getProject());
		}

		modelMap.put("dailyTimesheet", dailyTimesheet);
		modelMap.put("dailyTimesheets", dailyTimesheets);
		modelMap.put("timesheet", timesheet);
		modelMap.put("employee", Employee.findEmployee(employeeId));
		return "time/daily/month";
	}

	@RequestMapping(value = "/time/view/month/update", method = RequestMethod.POST)
	public String TimeController.updateTimesheetMonthView(@Valid DailyTimesheet dailyTimesheet,
			BindingResult result, HttpServletRequest request,
			ModelMap modelMap) {
		if (dailyTimesheet == null) {
			throw new IllegalArgumentException("DailyTimesheet is null.");
		}
        if (!DateUtils.getCurrentMonth().equals(DateUtils.getMonthInteger(dailyTimesheet.getDayDate()))) {
        	result.rejectValue("dayDate", "error.time.day.date.not.avaiable");
        }
		if (StringUtils.hasText(dailyTimesheet.getProjectName())) {
			logger.debug("Recieved project name: " + dailyTimesheet.getProjectName());
			try {
				Project project = projectService.loadOrCreateProject(dailyTimesheet.getProjectName());
				dailyTimesheet.setProject(project);
			} catch (Exception e) {
				logger.error("", e);
				result.rejectValue("projectName", "field.invalid");
			}
		} else {
			result.rejectValue("projectName", "field.required");
		}
		if (result.hasErrors()) {
			// Fill modelMap
			Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
			Timesheet timesheet = (Timesheet) Timesheet.findEmployeeCurrentTimesheet(employeeId).getSingleResult();
			modelMap.put("employee", Employee.findEmployee(employeeId));
			modelMap.put("timesheet", timesheet);
			modelMap.put("dailyTimesheets", timesheet.getDailyTimesheetsSortedList());

			return "time/daily/month";
		}
		Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
		Timesheet timesheet = (Timesheet) Timesheet.findEmployeeCurrentTimesheet(employeeId).getSingleResult();
		logger.debug("Resolving existent daily timesheet for: [" + timesheet + "] on [" + dailyTimesheet.getDayDate()
				+ "]");


		dailyTimesheet = dailyTimesheetService.createDailyTimesheet(dailyTimesheet, request);

		/**
		 * This was for updating an already existing daily time sheet!
		 */
		// DailyTimesheet dailyTimesheet2 = null;
		// try {
		// dailyTimesheet2 = (DailyTimesheet)
		// DailyTimesheet.findDailyTimesheetsByDayDateAndTimesheet(
		// dailyTimesheet.getDayDate(), timesheet).getSingleResult();
		// } catch (Exception e) {
		// logger.debug("No daily timesheet found for such criteria.");
		// }
		// if (dailyTimesheet2 == null) {
		// } else {
		// dailyTimesheet2.setDuration(dailyTimesheet.getDuration());
		// dailyTimesheet2.setDurationOffs(dailyTimesheet.getDurationOffs());
		// dailyTimesheet2.setDurationTraining(dailyTimesheet.getDurationTraining());
		// dailyTimesheet2.setProject(dailyTimesheet.getProject());
		// updateDailyTimesheet(dailyTimesheet2, result, modelMap);
		// }

		// see #prepareTimeseetMonthView to see why
		modelMap.addAttribute(WORKING_DAILY_TIMESHEET_KEY, dailyTimesheet);
		return prepareTimesheetMonthView(request, modelMap);
	}

	@RequestMapping(value = "/time/view/month/delete/{id}", method = RequestMethod.DELETE)
	public String TimeController.deleteTimesheetMonthView(@PathVariable("id") Long id) {
		if (id == null)
			throw new IllegalArgumentException("An Identifier is required");
		DailyTimesheet dailyTimesheet = DailyTimesheet.findDailyTimesheet(id);
		dailyTimesheetService.deleteDailyTimesheet(dailyTimesheet);
		return "redirect:/time/view/month";
	}
	
	@RequestMapping(value = "/time/timesheet/dailytimesheet/{timesheetId}/report/{format}", method = RequestMethod.GET)
	public String TimeController.reportDailyTimesheet(
			@PathVariable("timesheetId") Long timesheetId,
			@PathVariable("format") String format, ModelMap modelMap,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		if (timesheetId == null)
			throw new IllegalArgumentException("An Identifier is required");
		authorizeAccessTimesheet(timesheetId, request, response);
		Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(
				timesheet.getDailyTimesheetsSortedList(), false);
		modelMap.put("timesheetDailyReportList", jrDataSource);
		modelMap.put("format", format);
		return "timesheetDailyReportList";
	}

}