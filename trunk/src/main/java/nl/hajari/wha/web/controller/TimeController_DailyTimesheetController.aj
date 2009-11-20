package nl.hajari.wha.web.controller;

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

privileged aspect TimeController_DailyTimesheetController {
	
	@RequestMapping(value = "/time/daily/form", method = RequestMethod.GET)
	public String TimeController.createDailyTimesheetForm(ModelMap modelMap) {
		modelMap.addAttribute("dailytimesheet", new DailyTimesheet());
		modelMap.addAttribute("projects", Project.findAllProjects());
		modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
		return "time/daily/create";
	}
	
	@RequestMapping(value = "/time/daily", method = RequestMethod.POST)
	public String TimeController.createDailyTimesheet(@Valid DailyTimesheet dailytimesheet, BindingResult result, ModelMap modelMap) {
		if (dailytimesheet == null) { throw new IllegalArgumentException("A dailytimesheet is required"); }
		if (result.hasErrors()) {
			modelMap.addAttribute("projects", Project.findAllProjects());
			modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());
			return "time/daily/create";
		}
		dailytimesheet.persist();
		return "redirect:/time/daily/" + dailytimesheet.getId();
	}
	
    @RequestMapping(value = "/time/daily/{id}", method = RequestMethod.GET)    
    public String TimeController.showDailyTimesheet(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("dailytimesheet", DailyTimesheet.findDailyTimesheet(id));        
        return "time/daily/show";        
    }    
 
    @RequestMapping(value = "/time/daily", method = RequestMethod.GET)    
    public String TimeController.listDailyTimesheet(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("dailytimesheets", DailyTimesheet.findDailyTimesheetEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) DailyTimesheet.countDailyTimesheets() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("dailytimesheets", DailyTimesheet.findAllDailyTimesheets());            
        }        
        return "time/daily/list";        
    }    
    
    @RequestMapping(value = "/time/daily/update", method = RequestMethod.POST)    
    public String TimeController.updateDailyTimesheet(@Valid DailyTimesheet dailytimesheet, BindingResult result, ModelMap modelMap) {    
        if (dailytimesheet == null) throw new IllegalArgumentException("A dailytimesheet is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("projects", Project.findAllProjects());            
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());            
            return "time/daily/update";            
        }        
        dailytimesheet.merge();        
        return "redirect:/time/daily/" + dailytimesheet.getId();        
    }    
    
    @RequestMapping(value = "/time/daily/{id}/form", method = RequestMethod.GET)    
    public String TimeController.updateDailyTimesheetForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("dailytimesheet", DailyTimesheet.findDailyTimesheet(id));        
        modelMap.addAttribute("projects", Project.findAllProjects());        
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());        
        return "time/daily/update";        
    }    
    
    @RequestMapping(value = "/time/daily/{id}", method = RequestMethod.DELETE)    
    public String TimeController.deleteDailyTimesheet(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        DailyTimesheet.findDailyTimesheet(id).remove();        
        return "redirect:/time/daily";        
    }    
    
    @InitBinder    
    public void TimeController.initBinder(WebDataBinder binder) {    
        binder.registerCustomEditor(java.util.Date.class, new org.springframework.beans.propertyeditors.CustomDateEditor(new java.text.SimpleDateFormat("d/MM/yy"), true));        
    }    
    
}