package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import java.util.Date;
import javax.validation.Valid;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect DailyTimesheetController_Roo_Controller {
    
    @RequestMapping(value = "/dailytimesheet", method = RequestMethod.POST)    
    public String DailyTimesheetController.create(@Valid DailyTimesheet dailytimesheet, BindingResult result, ModelMap modelMap) {    
        if (dailytimesheet == null) throw new IllegalArgumentException("A dailytimesheet is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("projects", Project.findAllProjects());            
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());            
            return "dailytimesheet/create";            
        }        
        dailytimesheet.persist();        
        return "redirect:/dailytimesheet/" + dailytimesheet.getId();        
    }    
    
    @RequestMapping(value = "/dailytimesheet/form", method = RequestMethod.GET)    
    public String DailyTimesheetController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("dailytimesheet", new DailyTimesheet());        
        modelMap.addAttribute("projects", Project.findAllProjects());        
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());        
        return "dailytimesheet/create";        
    }    
    
    @RequestMapping(value = "/dailytimesheet/{id}", method = RequestMethod.GET)    
    public String DailyTimesheetController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("dailytimesheet", DailyTimesheet.findDailyTimesheet(id));        
        return "dailytimesheet/show";        
    }    
    
    @RequestMapping(value = "/dailytimesheet", method = RequestMethod.GET)    
    public String DailyTimesheetController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("dailytimesheets", DailyTimesheet.findDailyTimesheetEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) DailyTimesheet.countDailyTimesheets() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("dailytimesheets", DailyTimesheet.findAllDailyTimesheets());            
        }        
        return "dailytimesheet/list";        
    }    
    
    @RequestMapping(method = RequestMethod.PUT)    
    public String DailyTimesheetController.update(@Valid DailyTimesheet dailytimesheet, BindingResult result, ModelMap modelMap) {    
        if (dailytimesheet == null) throw new IllegalArgumentException("A dailytimesheet is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("projects", Project.findAllProjects());            
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());            
            return "dailytimesheet/update";            
        }        
        dailytimesheet.merge();        
        return "redirect:/dailytimesheet/" + dailytimesheet.getId();        
    }    
    
    @RequestMapping(value = "/dailytimesheet/{id}/form", method = RequestMethod.GET)    
    public String DailyTimesheetController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("dailytimesheet", DailyTimesheet.findDailyTimesheet(id));        
        modelMap.addAttribute("projects", Project.findAllProjects());        
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());        
        return "dailytimesheet/update";        
    }    
    
    @RequestMapping(value = "/dailytimesheet/{id}", method = RequestMethod.DELETE)    
    public String DailyTimesheetController.delete(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        DailyTimesheet.findDailyTimesheet(id).remove();        
        return "redirect:/dailytimesheet";        
    }    
    
    @InitBinder    
    public void DailyTimesheetController.initBinder(WebDataBinder binder) {    
        binder.registerCustomEditor(java.util.Date.class, new org.springframework.beans.propertyeditors.CustomDateEditor(new java.text.SimpleDateFormat("d/MM/yy"), true));        
    }    
    
    @RequestMapping(value = "find/ByTimesheet/form", method = RequestMethod.GET)    
    public String DailyTimesheetController.findDailyTimesheetsByTimesheetForm(ModelMap modelMap) {    
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());        
        return "dailytimesheet/findDailyTimesheetsByTimesheet";        
    }    
    
    @RequestMapping(value = "find/ByTimesheet", method = RequestMethod.GET)    
    public String DailyTimesheetController.findDailyTimesheetsByTimesheet(@RequestParam("timesheet") Timesheet timesheet, ModelMap modelMap) {    
        if (timesheet == null) throw new IllegalArgumentException("A Timesheet is required.");        
        modelMap.addAttribute("dailytimesheets", DailyTimesheet.findDailyTimesheetsByTimesheet(timesheet).getResultList());        
        return "dailytimesheet/list";        
    }    
    
    @RequestMapping(value = "find/ByDayDateAndTimesheet/form", method = RequestMethod.GET)    
    public String DailyTimesheetController.findDailyTimesheetsByDayDateAndTimesheetForm(ModelMap modelMap) {    
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());        
        return "dailytimesheet/findDailyTimesheetsByDayDateAndTimesheet";        
    }    
    
    @RequestMapping(value = "find/ByDayDateAndTimesheet", method = RequestMethod.GET)    
    public String DailyTimesheetController.findDailyTimesheetsByDayDateAndTimesheet(@RequestParam("daydate") Date dayDate, @RequestParam("timesheet") Timesheet timesheet, ModelMap modelMap) {    
        if (dayDate == null) throw new IllegalArgumentException("A DayDate is required.");        
        if (timesheet == null) throw new IllegalArgumentException("A Timesheet is required.");        
        modelMap.addAttribute("dailytimesheets", DailyTimesheet.findDailyTimesheetsByDayDateAndTimesheet(dayDate, timesheet).getResultList());        
        return "dailytimesheet/list";        
    }    
    
}
