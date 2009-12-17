package nl.hajari.wha.web.controller;

import java.lang.Integer;
import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.DailyTravel;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect TimesheetController_Roo_Controller {
    
    @RequestMapping(value = "/timesheet", method = RequestMethod.POST)    
    public String TimesheetController.create(@Valid Timesheet timesheet, BindingResult result, ModelMap modelMap) {    
        if (timesheet == null) throw new IllegalArgumentException("A timesheet is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("dailytimesheets", DailyTimesheet.findAllDailyTimesheets());            
            modelMap.addAttribute("dailytravels", DailyTravel.findAllDailyTravels());            
            modelMap.addAttribute("employees", Employee.findAllEmployees());            
            return "timesheet/create";            
        }        
        timesheet.persist();        
        return "redirect:/timesheet/" + timesheet.getId();        
    }    
    
    @RequestMapping(value = "/timesheet/form", method = RequestMethod.GET)    
    public String TimesheetController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("timesheet", new Timesheet());        
        modelMap.addAttribute("dailytimesheets", DailyTimesheet.findAllDailyTimesheets());        
        modelMap.addAttribute("dailytravels", DailyTravel.findAllDailyTravels());        
        modelMap.addAttribute("employees", Employee.findAllEmployees());        
        return "timesheet/create";        
    }    
    
    @RequestMapping(value = "/timesheet/{id}", method = RequestMethod.GET)    
    public String TimesheetController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));        
        return "timesheet/show";        
    }    
    
    @RequestMapping(value = "/timesheet", method = RequestMethod.GET)    
    public String TimesheetController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) Timesheet.countTimesheets() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());            
        }        
        return "timesheet/list";        
    }    
    
    @RequestMapping(value = "find/ByEmployeeAndSheetMonthAndSheetYearEquals/form", method = RequestMethod.GET)    
    public String TimesheetController.findTimesheetsByEmployeeAndSheetMonthAndSheetYearEqualsForm(ModelMap modelMap) {    
        modelMap.addAttribute("employees", Employee.findAllEmployees());        
        return "timesheet/findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals";        
    }    
    
    @RequestMapping(value = "find/ByEmployeeAndSheetMonthAndSheetYearEquals", method = RequestMethod.GET)    
    public String TimesheetController.findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals(@RequestParam("employee") Employee employee, @RequestParam("sheetmonth") Integer sheetMonth, @RequestParam("sheetyear") Integer sheetYear, ModelMap modelMap) {    
        if (employee == null) throw new IllegalArgumentException("A Employee is required.");        
        if (sheetMonth == null) throw new IllegalArgumentException("A SheetMonth is required.");        
        if (sheetYear == null) throw new IllegalArgumentException("A SheetYear is required.");        
        modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals(employee, sheetMonth, sheetYear).getResultList());        
        return "timesheet/list";        
    }    
    
}
