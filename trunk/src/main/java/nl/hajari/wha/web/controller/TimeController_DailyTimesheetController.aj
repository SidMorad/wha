package nl.hajari.wha.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect TimeController_DailyTimesheetController {

	@RequestMapping(value = "/time/daily/form", method = RequestMethod.GET)
	public String TimeController.createDailyTimesheetForm(ModelMap modelMap) {
		DailyTimesheet dailyTimesheet = new DailyTimesheet();
		dailyTimesheet.setDuration(0f);
		dailyTimesheet.setDurationOffs(0f);
		dailyTimesheet.setDurationTraining(0f);
		dailyTimesheet.setDailyTotalDuration(0f);
		modelMap.addAttribute("dailyTimesheet", dailyTimesheet);
		modelMap.addAttribute("projects", Project.findAllProjects());
		return "time/daily/create";
	}

	@RequestMapping(value = "/time/daily/{id}", method = RequestMethod.GET)
	public String TimeController.showDailyTimesheet(@PathVariable("id") Long id, ModelMap modelMap) {
		if (id == null)
			throw new IllegalArgumentException("An Identifier is required");
		modelMap.addAttribute("dailytimesheet", DailyTimesheet.findDailyTimesheet(id));
		return "time/daily/show";
	}

	@RequestMapping(value = "/time/daily", method = RequestMethod.GET)
	public String TimeController.listDailyTimesheet(@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
		if (page != null || size != null) {
			int sizeNo = size == null ? 10 : size.intValue();
			modelMap.addAttribute("dailytimesheets", DailyTimesheet.findDailyTimesheetEntries(page == null ? 0 : (page
					.intValue() - 1)
					* sizeNo, sizeNo));
			float nrOfPages = (float) DailyTimesheet.countDailyTimesheets() / sizeNo;
			modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1
					: nrOfPages));
		} else {
			modelMap.addAttribute("dailytimesheets", DailyTimesheet.findAllDailyTimesheets());
		}
		return "time/daily/list";
	}

	@RequestMapping(value = "/time/daily/update", method = RequestMethod.POST)
	@Transactional
	public String TimeController.updateDailyTimesheet(@Valid DailyTimesheet dailyTimesheet, BindingResult result,
			ModelMap modelMap) {
		if (dailyTimesheet == null)
			throw new IllegalArgumentException("A dailytimesheet is required");
		if (result.hasErrors()) {
			modelMap.addAttribute("projects", Project.findAllProjects());
			return "time/daily/update";
		}
		dailyTimesheet.setDailyTotalDuration(dailyTimesheet.getDuration() + dailyTimesheet.getDurationTraining()
				- dailyTimesheet.getDurationOffs());
		dailyTimesheet.merge();
		dailyTimesheet.flush();
		// now we update monthlyTotal in Timesheet
		Long tsId = dailyTimesheet.getTimesheet().getId();
		Float total = DailyTimesheet.findTimesheetTotalMonthly(tsId);
		logger.debug("Updating timesheet[" + tsId + "] to total [" + total + "]");
		Timesheet.updateTimesheetTotalMonthly(tsId, total);
		return "redirect:/time/daily/" + dailyTimesheet.getId();
	}

	@RequestMapping(value = "/time/daily/{id}/form", method = RequestMethod.GET)
	public String TimeController.updateDailyTimesheetForm(@PathVariable("id") Long id, ModelMap modelMap) {
		if (id == null)
			throw new IllegalArgumentException("An Identifier is required");
		modelMap.addAttribute("dailyTimesheet", DailyTimesheet.findDailyTimesheet(id));
		modelMap.addAttribute("projects", Project.findAllProjects());
		return "time/daily/update";
	}

	@RequestMapping(value = "/time/daily/{id}", method = RequestMethod.DELETE)
	@Transactional
	public String TimeController.deleteDailyTimesheet(@PathVariable("id") Long id, ModelMap modelMap) {
		if (id == null)
			throw new IllegalArgumentException("An Identifier is required");

		DailyTimesheet dailyTimesheet = DailyTimesheet.findDailyTimesheet(id);
		Long tsId = dailyTimesheet.getTimesheet().getId();
		dailyTimesheet.remove();

		// now we update monthlyTotal in Timesheet table
		Timesheet.updateTimesheetTotalMonthly(tsId, DailyTimesheet.findTimesheetTotalMonthly(tsId));

		modelMap.addAttribute("timesheet", Timesheet.findTimesheet(tsId));
		return "time/timesheet/show";
	}

	@SuppressWarnings("unchecked")
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
		modelMap.put("dailyTimesheet", dailyTimesheet);
		modelMap.put("projects", Project.findAllProjects());
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
		if (result.hasErrors()) {
			// TODO
			return "time/view/month";
		}
		Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
		Timesheet timesheet = (Timesheet) Timesheet.findEmployeeCurrentTimesheet(employeeId).getSingleResult();
		logger.debug("Resolving existent daily timesheet for: [" + timesheet + "] on [" + dailyTimesheet.getDayDate()
				+ "]");
		DailyTimesheet dailyTimesheet2 = null;
		try {
			dailyTimesheet2 = (DailyTimesheet) DailyTimesheet.findDailyTimesheetsByDayDateAndTimesheet(
					dailyTimesheet.getDayDate(), timesheet).getSingleResult();
		} catch (Exception e) {
			logger.debug("No daily timesheet found for such criteria.");
		}
		if (dailyTimesheet2 == null) {
			createDailyTimesheet(dailyTimesheet, result, modelMap);
		} else {
			dailyTimesheet2.setDuration(dailyTimesheet.getDuration());
			dailyTimesheet2.setDurationOffs(dailyTimesheet.getDurationOffs());
			dailyTimesheet2.setDurationTraining(dailyTimesheet.getDurationTraining());
			dailyTimesheet2.setProject(dailyTimesheet.getProject());
			updateDailyTimesheet(dailyTimesheet2, result, modelMap);
		}
		return prepareTimesheetMonthView(request, modelMap);
	}

}