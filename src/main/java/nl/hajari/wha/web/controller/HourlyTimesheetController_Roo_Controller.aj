package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.HourlyTimesheet;
import nl.hajari.wha.domain.Project;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect HourlyTimesheetController_Roo_Controller {
    
    @RequestMapping(value = "/hourlytimesheet", method = RequestMethod.POST)    
    public String HourlyTimesheetController.create(@Valid HourlyTimesheet hourlytimesheet, BindingResult result, ModelMap modelMap) {    
        if (hourlytimesheet == null) throw new IllegalArgumentException("A hourlytimesheet is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("dailytimesheets", DailyTimesheet.findAllDailyTimesheets());            
            modelMap.addAttribute("projects", Project.findAllProjects());            
            return "hourlytimesheet/create";            
        }        
        hourlytimesheet.persist();        
        return "redirect:/hourlytimesheet/" + hourlytimesheet.getId();        
    }    
    
    @RequestMapping(value = "/hourlytimesheet/form", method = RequestMethod.GET)    
    public String HourlyTimesheetController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("hourlytimesheet", new HourlyTimesheet());        
        modelMap.addAttribute("dailytimesheets", DailyTimesheet.findAllDailyTimesheets());        
        modelMap.addAttribute("projects", Project.findAllProjects());        
        return "hourlytimesheet/create";        
    }    
    
    @RequestMapping(value = "/hourlytimesheet/{id}", method = RequestMethod.GET)    
    public String HourlyTimesheetController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("hourlytimesheet", HourlyTimesheet.findHourlyTimesheet(id));        
        return "hourlytimesheet/show";        
    }    
    
    @RequestMapping(value = "/hourlytimesheet", method = RequestMethod.GET)    
    public String HourlyTimesheetController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("hourlytimesheets", HourlyTimesheet.findHourlyTimesheetEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) HourlyTimesheet.countHourlyTimesheets() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("hourlytimesheets", HourlyTimesheet.findAllHourlyTimesheets());            
        }        
        return "hourlytimesheet/list";        
    }    
    
    @RequestMapping(method = RequestMethod.PUT)    
    public String HourlyTimesheetController.update(@Valid HourlyTimesheet hourlytimesheet, BindingResult result, ModelMap modelMap) {    
        if (hourlytimesheet == null) throw new IllegalArgumentException("A hourlytimesheet is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("dailytimesheets", DailyTimesheet.findAllDailyTimesheets());            
            modelMap.addAttribute("projects", Project.findAllProjects());            
            return "hourlytimesheet/update";            
        }        
        hourlytimesheet.merge();        
        return "redirect:/hourlytimesheet/" + hourlytimesheet.getId();        
    }    
    
    @RequestMapping(value = "/hourlytimesheet/{id}/form", method = RequestMethod.GET)    
    public String HourlyTimesheetController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("hourlytimesheet", HourlyTimesheet.findHourlyTimesheet(id));        
        modelMap.addAttribute("dailytimesheets", DailyTimesheet.findAllDailyTimesheets());        
        modelMap.addAttribute("projects", Project.findAllProjects());        
        return "hourlytimesheet/update";        
    }    
    
    @RequestMapping(value = "/hourlytimesheet/{id}", method = RequestMethod.DELETE)    
    public String HourlyTimesheetController.delete(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        HourlyTimesheet.findHourlyTimesheet(id).remove();        
        return "redirect:/hourlytimesheet";        
    }    
    
    @InitBinder    
    public void HourlyTimesheetController.initBinder(WebDataBinder binder) {    
        binder.registerCustomEditor(java.util.Date.class, new org.springframework.beans.propertyeditors.CustomDateEditor(new java.text.SimpleDateFormat("d/MM/yy"), true));        
    }    
    
}
