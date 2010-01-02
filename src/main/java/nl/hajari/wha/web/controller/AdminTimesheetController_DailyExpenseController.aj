package nl.hajari.wha.web.controller;

import javax.validation.Valid;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.DailyExpense;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.web.util.DateUtils;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect AdminTimesheetController_DailyExpenseController {
    
	@RequestMapping(value = "/admin/timesheet/dailyexpense", method = RequestMethod.POST)    
    public String AdminTimesheetController.createDailyExpense(@Valid DailyExpense dailyexpense, BindingResult result, ModelMap modelMap) {    
        if (dailyexpense == null) throw new IllegalArgumentException("A dailyexpense is required");
        if (!dailyexpense.getTimesheet().getSheetMonth().equals(DateUtils.getMonthInteger(dailyexpense.getDayDate()))) {
        	result.rejectValue("timesheet", "error.time.day.date.not.match");
        }
        if (result.hasErrors()) {        
            modelMap.addAttribute("customers", Customer.findAllCustomers());            
            modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(dailyexpense.getTimesheet().getEmployee()).getResultList());            
            return "admin/timesheet/dailyexpense/create";            
        }        
        dailyexpense.persist();        
        return "redirect:/admin/timesheet/dailyexpense/" + dailyexpense.getId();        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailyexpense/form/{employeeId}", method = RequestMethod.GET)    
    public String AdminTimesheetController.createFormDailyExpense(@PathVariable("employeeId") Long employeeId,ModelMap modelMap) {    
        modelMap.addAttribute("dailyExpense", new DailyExpense());        
        modelMap.addAttribute("customers", Customer.findAllCustomers());        
        modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(Employee.findEmployee(employeeId)).getResultList());        
        return "admin/timesheet/dailyexpense/create";        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailyexpense/{id}", method = RequestMethod.GET)    
    public String AdminTimesheetController.showDailyExpense(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("dailyexpense", DailyExpense.findDailyExpense(id));        
        return "admin/timesheet/dailyexpense/show";        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailyexpense/update", method = RequestMethod.POST)    
    public String AdminTimesheetController.updateDailyExpense(@Valid DailyExpense dailyexpense, BindingResult result, ModelMap modelMap) {    
        if (dailyexpense == null) throw new IllegalArgumentException("A dailyexpense is required");  
        if (!dailyexpense.getTimesheet().getSheetMonth().equals(DateUtils.getMonthInteger(dailyexpense.getDayDate()))) {
        	result.rejectValue("timesheet", "error.time.day.date.not.match");
        }
        if (result.hasErrors()) {        
            modelMap.addAttribute("customers", Customer.findAllCustomers());            
            modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(dailyexpense.getTimesheet().getEmployee()).getResultList());            
            return "admin/timesheet/dailyexpense/update";            
        }        
        dailyexpense.merge();        
        return "redirect:/admin/timesheet/dailyexpense/" + dailyexpense.getId();        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailyexpense/{id}/form", method = RequestMethod.GET)    
    public String AdminTimesheetController.updateFormDailyExpense(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        DailyExpense dailyExpense = DailyExpense.findDailyExpense(id);
        modelMap.addAttribute("dailyExpense", dailyExpense);        
        modelMap.addAttribute("customers", Customer.findAllCustomers());        
        modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(dailyExpense.getTimesheet().getEmployee()).getResultList());        
        return "admin/timesheet/dailyexpense/update";        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailyexpense/{id}", method = RequestMethod.DELETE)    
    public String AdminTimesheetController.deleteDailyExpense(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        DailyExpense dailyExpense = DailyExpense.findDailyExpense(id);
        Long timesheetId = dailyExpense.getTimesheet().getId();
        dailyExpense.remove();
        return "redirect:/admin/timesheet/expense/" + timesheetId;        
    }    

    @RequestMapping(value = "/admin/timesheet/dailyexpense/{timesheetId}/report/{format}" , method = RequestMethod.GET)
    public String AdminTimesheetController.reportDailyExpense(@PathVariable("timesheetId")Long timesheetId, @PathVariable("format") String format, ModelMap modelMap) {
    	Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
    	JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(timesheet.getDailyExpensesSortedList(),false);
    	modelMap.put("timesheetExpenseReportList", jrDataSource);
    	modelMap.put("format", format);
    	return "timesheetExpenseReportList";
    }
    
}
