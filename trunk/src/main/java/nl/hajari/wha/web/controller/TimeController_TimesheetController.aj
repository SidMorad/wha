package nl.hajari.wha.web.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import nl.hajari.wha.Constants;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.web.controller.formbean.TimesheetSearchFormBean;
import nl.hajari.wha.web.util.DateUtils;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

privileged aspect TimeController_TimesheetController {

	@RequestMapping(value = "/time/timesheet/daily", method = RequestMethod.GET)
	public String TimeController.listTimesheetDaily(ModelMap modelMap, HttpServletRequest request) {
		Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
		if (employeeId == null) {
			throw new IllegalArgumentException("Employee Id is required.");
		}
			
		//modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeIdAndCurrentYear(employeeId));
		modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeId(employeeId));
		modelMap.put("employee", Employee.findEmployee(employeeId));
		return "time/timesheet/daily/list";
	}

	@RequestMapping(value = "/time/timesheet/travel", method = RequestMethod.GET)
	public String TimeController.listTimesheetTravel(ModelMap modelMap, HttpServletRequest request) {
		Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
		if (employeeId == null) {
			throw new IllegalArgumentException("Employee Id is required.");
		}
		
		//modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeIdAndCurrentYear(employeeId));
		modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeId(employeeId));
		modelMap.put("employee", Employee.findEmployee(employeeId));
		return "time/timesheet/travel/list";
	}

	@RequestMapping(value = "/time/timesheet/expense", method = RequestMethod.GET)
	public String TimeController.listTimesheetExpense(ModelMap modelMap, HttpServletRequest request) {
		Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
		if (employeeId == null) {
			throw new IllegalArgumentException("Employee Id is required.");
		}
		
		//modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeIdAndCurrentYear(employeeId));
		modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByEmployeeId(employeeId));
		modelMap.put("employee", Employee.findEmployee(employeeId));
		return "time/timesheet/expense/list";
	}

	@RequestMapping(value = "/time/timesheet/daily/{id}", method = RequestMethod.GET)
	public String TimeController.showTimesheetDaily(@PathVariable("id") Long id, HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		if (id == null) {
			throw new IllegalArgumentException("An Identifer is required");
		}
		authorizeAccessTimesheet(id, request, response);
		modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));
		return "time/timesheet/daily/show";
	}

	@RequestMapping(value = "/time/timesheet/travel/{id}", method = RequestMethod.GET)
	public String TimeController.showTimesheetTravel(@PathVariable("id") Long id, HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		if (id == null) {
			throw new IllegalArgumentException("An Identifer is required");
		}
		authorizeAccessTimesheet(id, request, response);
		modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));
		return "time/timesheet/travel/show";
	}

	@RequestMapping(value = "/time/timesheet/expense/{id}", method = RequestMethod.GET)
	public String TimeController.showTimesheetExpense(@PathVariable("id") Long id, HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		if (id == null) {
			throw new IllegalArgumentException("An Identifer is required");
		}
		authorizeAccessTimesheet(id, request, response);
		modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));
		return "time/timesheet/expense/show";
	}
	
    @RequestMapping(value = "/time/timesheet/search/form", method = RequestMethod.GET)
    public String TimeController.displaySearchTimesheetForm(ModelMap modelMap, HttpServletRequest request) {
    	TimesheetSearchFormBean form = new TimesheetSearchFormBean();
    	Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
    	Employee employee = Employee.findEmployee(employeeId);
    	form.setEmployee(employee);
    	modelMap.addAttribute("timesheetSearchFormBean", form);
    	return "time/timesheet/search";
    }
	
	
    @RequestMapping(value = "/time/timesheet/search", method = RequestMethod.POST)
    public String TimeController.searchTimesheet(@Valid TimesheetSearchFormBean formBean, ModelMap modelMap) {
    	Employee employee = formBean.getEmployee();
    	Integer fromYear = DateUtils.getYearInteger(formBean.getFrom());
    	Integer fromMonth = DateUtils.getMonthInteger(formBean.getFrom());
    	Integer toYear = DateUtils.getYearInteger(formBean.getTo());
    	Integer toMonth = DateUtils.getMonthInteger(formBean.getTo());
    	List<Timesheet> timesheets = Timesheet.findAllTimesheetsByEmployeeAndSheetMonthAndSheetYearBetween(employee, fromYear, fromMonth, toYear, toMonth).getResultList();
    	List<DailyTimesheet> dailyTimesheets = new ArrayList<DailyTimesheet>();
    	for (Timesheet timesheet : timesheets) {
    		DailyTimesheet totalDt = dailyTimesheetService.getTotalDailyTimesheetPerMonthBetweenTwoDates(timesheet.getDailyTimesheetsSortedList(), formBean.getFrom(), formBean.getTo());
    		if (totalDt != null) {
    			dailyTimesheets.add(totalDt);
    		}
    	}
    	
    	modelMap.addAttribute("dailyTimesheets", dailyTimesheets);
    	modelMap.addAttribute("employeeId", employee.getId());
    	return "time/timesheet/search";
    }

    @RequestMapping(value = "/time/timesheet/search/{fromDate}/{toDate}/report/{format}" , method = RequestMethod.GET)
    public String TimeController.reportTimesheetSearchResults(
    		@PathVariable("fromDate") String fromDateString, 
    		@PathVariable("toDate") String toDateString, 
    		@PathVariable("format") String format,
    		ModelMap modelMap, HttpServletRequest request) {
    	Date fromDate = DateUtils.getDateObject(fromDateString, "dd-MM-yyyy");
    	Date toDate = DateUtils.getDateObject(toDateString, "dd-MM-yyyy");
    	Integer fromYear = DateUtils.getYearInteger(fromDate);
    	Integer fromMonth = DateUtils.getMonthInteger(fromDate);
    	Integer fromDay = DateUtils.getDayInteger(fromDate);
    	Integer toYear = DateUtils.getYearInteger(toDate);
    	Integer toMonth = DateUtils.getMonthInteger(toDate);
    	Integer toDay = DateUtils.getDayInteger(toDate);
    	Long employeeId = (Long) request.getSession().getAttribute(Employee.EMPLOYEE_ID);
    	Employee employee = Employee.findEmployee(employeeId);
    	List<Timesheet> timesheets = Timesheet.findAllTimesheetsByEmployeeAndSheetMonthAndSheetYearBetween(employee, fromYear, fromMonth, toYear, toMonth).getResultList();
    	List<DailyTimesheet> dailyTimesheets = new ArrayList<DailyTimesheet>();
    	for (Timesheet timesheet : timesheets) {
    		DailyTimesheet totalDt = dailyTimesheetService.getTotalDailyTimesheetPerMonthBetweenTwoDates(timesheet.getDailyTimesheetsSortedList(), fromDate, toDate);
    		if (totalDt != null) {
    			dailyTimesheets.add(totalDt);
    		}
    	}
    	
    	JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(dailyTimesheets,false);
    	modelMap.put("timesheetDailySearchReportList", jrDataSource);
    	
    	// Fill ProjectSubReport
    	List<DailyTimesheet> dts = dailyTimesheetService.getDailyTimesheetListForReportPerProject(dailyTimesheets);
    	modelMap.put("ProjectSubReportData", new JRBeanCollectionDataSource(dts, false));
    	
    	modelMap.put("format", format);
    	modelMap.put(Constants.IMAGE_HM_LOGO, getFileFullPath(request, Constants.imageHMlogoAddress));
    	modelMap.put("fromDate", fromYear + " " + DateUtils.getSheetMonthShortName(fromMonth) + " " + fromDay);
    	modelMap.put("toDate", toYear + " " + DateUtils.getSheetMonthShortName(toMonth) + " " + toDay);
    	modelMap.put("reportFileName", employee.getFirstName() + "_" + employee.getLastName() + "_" + fromYear + "-" + fromMonth + "-" + toYear + "-" + toMonth);
    	return "timesheetDailySearchReportList";
    }

}
