package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.DailyTravel;
import nl.hajari.wha.domain.Timesheet;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect DailyTravelController_Roo_Controller {
    
    @RequestMapping(value = "/dailytravel", method = RequestMethod.POST)    
    public String DailyTravelController.create(@Valid DailyTravel dailytravel, BindingResult result, ModelMap modelMap) {    
        if (dailytravel == null) throw new IllegalArgumentException("A dailytravel is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());            
            return "dailytravel/create";            
        }        
        dailytravel.persist();        
        return "redirect:/dailytravel/" + dailytravel.getId();        
    }    
    
    @RequestMapping(value = "/dailytravel/form", method = RequestMethod.GET)    
    public String DailyTravelController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("dailytravel", new DailyTravel());        
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());        
        return "dailytravel/create";        
    }    
    
    @RequestMapping(value = "/dailytravel/{id}", method = RequestMethod.GET)    
    public String DailyTravelController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("dailytravel", DailyTravel.findDailyTravel(id));        
        return "dailytravel/show";        
    }    
    
    @RequestMapping(value = "/dailytravel", method = RequestMethod.GET)    
    public String DailyTravelController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("dailytravels", DailyTravel.findDailyTravelEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) DailyTravel.countDailyTravels() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("dailytravels", DailyTravel.findAllDailyTravels());            
        }        
        return "dailytravel/list";        
    }    
    
    @RequestMapping(method = RequestMethod.PUT)    
    public String DailyTravelController.update(@Valid DailyTravel dailytravel, BindingResult result, ModelMap modelMap) {    
        if (dailytravel == null) throw new IllegalArgumentException("A dailytravel is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());            
            return "dailytravel/update";            
        }        
        dailytravel.merge();        
        return "redirect:/dailytravel/" + dailytravel.getId();        
    }    
    
    @RequestMapping(value = "/dailytravel/{id}/form", method = RequestMethod.GET)    
    public String DailyTravelController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("dailytravel", DailyTravel.findDailyTravel(id));        
        modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());        
        return "dailytravel/update";        
    }    
    
    @RequestMapping(value = "/dailytravel/{id}", method = RequestMethod.DELETE)    
    public String DailyTravelController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        DailyTravel.findDailyTravel(id).remove();        
        return "redirect:/dailytravel?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());        
    }    
    
}
