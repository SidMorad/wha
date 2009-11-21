package nl.hajari.wha.web.controller;

import java.util.Calendar;
import java.util.Date;

import javax.validation.Valid;

import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/time/**")
@Controller
public class TimeController {

	@Autowired
	TimesheetController timesheetController;
	
	@RequestMapping(value = "/time/daily", method = RequestMethod.POST)
	public String createDailyTimesheet(@Valid DailyTimesheet dailyTimesheet, BindingResult result, ModelMap modelMap) {
		if (dailyTimesheet == null) { throw new IllegalArgumentException("A dailyTimesheet is required"); }
		if (dailyTimesheet.getDayDate() != null) {
			// Employees could only edit or enters time in current month
			if (!isDayDateInCurrentMonth(dailyTimesheet.getDayDate())) {
				result.rejectValue("dayDate", "error.time.daily.not.avaiable");
			} else {
				Timesheet timesheet = timesheetController.getTimesheetByDayDateAndCurrentEmployee(dailyTimesheet.getDayDate());
				if (timesheet == null) {
					// we the correct settings we shouldn't see this message , but we have it in case .
					result.rejectValue("dayDate" ,"error.time.timesheet.not.avaiable");
				} else {
					dailyTimesheet.setTimesheet(timesheet);
					// we also could update total duration time 
					timesheet.setMonthlyTotal(timesheet.getMonthlyTotal()+dailyTimesheet.getDuration());
					timesheet.persist();
				}
			}
		} else {
			result.rejectValue("dayDate", "error.time.daily.not.null");
		}
		
		if (result.hasErrors()) {
			modelMap.addAttribute("projects", Project.findAllProjects());
			return "time/daily/create";
		}

//		dailytimesheet.setTimesheet(timesheet)
		dailyTimesheet.persist();
		
		return "redirect:/time/daily/" + dailyTimesheet.getId();
	}

	private boolean isDayDateInCurrentMonth(Date dayDate) {
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(new Date());
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(dayDate);
		
		if (cal1.get(Calendar.YEAR) != cal2.get(Calendar.YEAR) || cal1.get(Calendar.MONTH) != cal2.get(Calendar.MONTH)) {
			return false;
		}
		return true;
	}
}
