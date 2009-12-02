package nl.hajari.wha.web.controller;

import javax.validation.Valid;

import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/time/**")
@Controller
public class TimeController {
	
	protected final Log logger = LogFactory.getLog(getClass());

	@Autowired
	TimesheetController timesheetController;
	
	@RequestMapping(value = "/time/daily", method = RequestMethod.POST)
	@Transactional
	public String createDailyTimesheet(@Valid DailyTimesheet dailyTimesheet, BindingResult result, ModelMap modelMap) {
		if (dailyTimesheet == null) { throw new IllegalArgumentException("A dailyTimesheet is required"); }

		if (!result.hasErrors()) {
			Timesheet timesheet = timesheetController.getTimesheetByDayDateAndCurrentEmployee(dailyTimesheet.getDayDate());
			if (timesheet == null) {
				// we the correct settings we shouldn't see this message , but we have it in case .
				result.rejectValue("dayDate" ,"error.time.timesheet.not.avaiable");
			} else {
				dailyTimesheet.setTimesheet(timesheet);
			}
		}	
		
		if (result.hasErrors()) {
			modelMap.addAttribute("projects", Project.findAllProjects());
			return "time/daily/create";
		}
		
		// calculate dailyTotalDuration = duration + durationTraining - durationOffs
		dailyTimesheet.setDailyTotalDuration(dailyTimesheet.getDuration() + dailyTimesheet.getDurationTraining() - dailyTimesheet.getDurationOffs());
		dailyTimesheet.persist();
		dailyTimesheet.flush();
		// now we update monthlyTotalDuration in timesheet entity
		Long timesheetId = dailyTimesheet.getTimesheet().getId();
		Timesheet.updateTimesheetTotalMonthly(timesheetId, DailyTimesheet.findTimesheetTotalMonthly(timesheetId));
		return "redirect:/time/daily/" + dailyTimesheet.getId();
	}
	
   @InitBinder    
    public void initBinder(WebDataBinder binder) {    
        binder.registerCustomEditor(java.util.Date.class, new org.springframework.beans.propertyeditors.CustomDateEditor(new java.text.SimpleDateFormat("d/MM/yy"), true));        
   }

}
