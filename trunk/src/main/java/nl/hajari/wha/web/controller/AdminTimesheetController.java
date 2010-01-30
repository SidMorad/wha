package nl.hajari.wha.web.controller;

import javax.servlet.http.HttpServletRequest;

import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.impl.DailyExpenseServiceImpl;
import nl.hajari.wha.service.impl.DailyTimesheetServiceImpl;
import nl.hajari.wha.service.impl.ProjectServiceImpl;
import nl.hajari.wha.web.controller.formbean.TimesheetDailyReportFormBean;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminTimesheetController {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	@Autowired
	protected DailyTimesheetServiceImpl dailyTimesheetService;
	
	@Autowired
	protected ProjectServiceImpl projectService;
	
	@Autowired
	protected DailyExpenseServiceImpl dailyExpenseService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(java.util.Date.class,
				new org.springframework.beans.propertyeditors.CustomDateEditor(
				new java.text.SimpleDateFormat("d/MM/yy"), true));
	}
	
    @RequestMapping(value = "/admin/timesheet", method = RequestMethod.GET)    
    public String listTimesheetAll(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) Timesheet.countTimesheets() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("timesheets", Timesheet.findAllTimesheets());            
        }        
        return "admin/timesheet/list";        
    }   
	
    @RequestMapping(value = "/admin/timesheet/daily/{id}", method = RequestMethod.GET)    
    public String showTimesheetDaily(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));
        modelMap.addAttribute("timesheetDailyReportFormBean", new TimesheetDailyReportFormBean());
        modelMap.addAttribute("customers", Customer.findAllCustomers());
        return "admin/timesheet/daily/show";        
    }   
    
    @RequestMapping(value = "/admin/timesheet/travel/{id}", method = RequestMethod.GET)    
    public String showTimesheetTravel(@PathVariable("id") Long id, ModelMap modelMap) {    
    	if (id == null) throw new IllegalArgumentException("An Identifier is required");        
    	modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));        
    	return "admin/timesheet/travel/show";        
    }   

    @RequestMapping(value = "/admin/timesheet/expense/{id}", method = RequestMethod.GET)    
    public String showTimesheetExpense(@PathVariable("id") Long id, ModelMap modelMap) {    
    	if (id == null) throw new IllegalArgumentException("An Identifier is required");        
    	modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));        
    	return "admin/timesheet/expense/show";        
    }   
    
	public String getFileFullPath(HttpServletRequest request, String filePath){
		String appServerHome = request.getSession().getServletContext().getRealPath("/");
		return appServerHome + filePath;
	}	

}
