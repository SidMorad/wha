package nl.hajari.wha.web.controller;

import javax.validation.Valid;

import nl.hajari.wha.domain.DailyTravel;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.web.util.DateUtils;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

privileged aspect AdminTimesheetController_DailyTravelController {
    
    @RequestMapping(value = "/admin/timesheet/dailytravel", method = RequestMethod.POST)    
    public String AdminTimesheetController.createDailyTravel(@Valid DailyTravel dailyTravel, BindingResult result, ModelMap modelMap) {    
        if (dailyTravel == null) throw new IllegalArgumentException("A dailytravel is required");        
        if (!dailyTravel.getTimesheet().getSheetMonth().equals(DateUtils.getMonthInteger(dailyTravel.getDayDate()))) {
        	result.rejectValue("timesheet", "error.time.day.date.not.match");
        }
        if (result.hasErrors()) {        
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());            
            return "admin/timesheet/dailytravel/create";            
        }        
        dailyTravel.persist();        
        return "redirect:/admin/timesheet/dailytravel/" + dailyTravel.getId();        
    }    
	
	@RequestMapping(value = "/admin/timesheet/dailytravel/form/{employeeId}", method = RequestMethod.GET)    
    public String AdminTimesheetController.createFormDailyTravel(@PathVariable("employeeId") Long employeeId, ModelMap modelMap) {    
        modelMap.addAttribute("dailyTravel", new DailyTravel());        
        modelMap.addAttribute("timesheets",  Timesheet.findTimesheetsByEmployee(Employee.findEmployee(employeeId)).getResultList());        
        return "admin/timesheet/dailytravel/create";        
    }   
	
	   
    @RequestMapping(value = "/admin/timesheet/dailytravel/{id}", method = RequestMethod.GET)    
    public String AdminTimesheetController.showDailyTravel(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("dailyTravel", DailyTravel.findDailyTravel(id));        
        return "admin/timesheet/dailytravel/show";        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailytravel/update", method = RequestMethod.POST)    
    public String AdminTimesheetController.updateDailyTravel(@Valid DailyTravel dailyTravel, BindingResult result, ModelMap modelMap) {    
        if (dailyTravel == null) throw new IllegalArgumentException("A dailytravel is required");        
        if (!dailyTravel.getTimesheet().getSheetMonth().equals(DateUtils.getMonthInteger(dailyTravel.getDayDate()))) {
        	result.rejectValue("timesheet", "error.time.day.date.not.match");
        }
        if (result.hasErrors()) {        
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());            
            return "admin/timesheet/dailytravel/update";            
        }        
        dailyTravel.merge();        
        return "redirect:/admin/timesheet/dailytravel/" + dailyTravel.getId();        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailytravel/{id}/form", method = RequestMethod.GET)    
    public String AdminTimesheetController.updateFormDailyTravel(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        DailyTravel dailyTravel = DailyTravel.findDailyTravel(id); 
        modelMap.addAttribute("dailyTravel", dailyTravel);        
        modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(dailyTravel.getTimesheet().getEmployee()).getResultList());        
        return "admin/timesheet/dailytravel/update";        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailytravel/{id}", method = RequestMethod.DELETE)    
    public String AdminTimesheetController.deleteDailyTravel(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        DailyTravel dailyTravel = DailyTravel.findDailyTravel(id);
        Long timesheetId = dailyTravel.getTimesheet().getId();
        dailyTravel.remove();        
        return "redirect:/admin/timesheet/travel/" + timesheetId;        
    }    
}
