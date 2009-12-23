package nl.hajari.wha.web.controller;

import javax.validation.Valid;

import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

privileged aspect AdminTimesheetController_DailyTimesheetController {

    @RequestMapping(value = "/admin/timesheet/dailytimesheet", method = RequestMethod.POST)    
    public String AdminTimesheetController.createDailyTimesheet(@Valid DailyTimesheet dailyTimesheet, BindingResult result, ModelMap modelMap) {    
        if (dailyTimesheet == null) throw new IllegalArgumentException("A dailytimesheet is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("projects", Project.findAllProjects());            
            modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(dailyTimesheet.getTimesheet().getEmployee()).getResultList());            
            return "admin/timesheet/dailytimesheet/create";            
        }        
        dailyTimesheet = dailyTimesheetService.createDailyTimesheet(dailyTimesheet);    
        return "redirect:/admin/timesheet/dailytimesheet/" + dailyTimesheet.getId();        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailytimesheet/form/{employeeId}", method = RequestMethod.GET)    
    public String AdminTimesheetController.createFormDailyTimesheet(@PathVariable("employeeId") Long employeeId, ModelMap modelMap) {    
        modelMap.addAttribute("dailyTimesheet", new DailyTimesheet());        
        modelMap.addAttribute("projects", Project.findAllProjects());        
        modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(Employee.findEmployee(employeeId)).getResultList());        
        return "admin/timesheet/dailytimesheet/create";        
    }    
    @RequestMapping(value = "/admin/timesheet/dailytimesheet/{id}", method = RequestMethod.GET)    
    public String AdminTimesheetController.showDailyTimesheet(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("dailytimesheet", DailyTimesheet.findDailyTimesheet(id));        
        return "admin/timesheet/dailytimesheet/show";        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailytimesheet/update", method = RequestMethod.POST)    
    public String AdminTimesheetController.updateDailyTimesheet(@Valid DailyTimesheet dailyTimesheet, BindingResult result, ModelMap modelMap) {    
        if (dailyTimesheet == null) throw new IllegalArgumentException("A dailytimesheet is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("projects", Project.findAllProjects());            
            modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(dailyTimesheet.getTimesheet().getEmployee()).getResultList());            
            return "admin/timesheet/dailytimesheet/update";            
        }        
        dailyTimesheetService.updateDailyTimesheet(dailyTimesheet);
        return "redirect:/admin/timesheet/dailytimesheet/" + dailyTimesheet.getId();        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailytimesheet/{id}/form", method = RequestMethod.GET)    
    public String AdminTimesheetController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        DailyTimesheet dailyTimesheet = DailyTimesheet.findDailyTimesheet(id);
        modelMap.addAttribute("dailyTimesheet", dailyTimesheet);        
        modelMap.addAttribute("projects", Project.findAllProjects());        
        modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(dailyTimesheet.getTimesheet().getEmployee()).getResultList());        
        return "admin/timesheet/dailytimesheet/update";        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailytimesheet/{id}", method = RequestMethod.DELETE)    
    public String AdminTimesheetController.delete(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        DailyTimesheet dailyTimesheet = DailyTimesheet.findDailyTimesheet(id);  
        Long timesheetId = dailyTimesheetService.deleteDailyTimesheet(dailyTimesheet);
        return "redirect:/admin/timesheet/daily/" + timesheetId;        
    }    
    
}
