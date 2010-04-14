package nl.hajari.wha.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import nl.hajari.wha.Constants;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.web.controller.formbean.TimesheetDailyReportFormBean;
import nl.hajari.wha.web.util.DateUtils;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

privileged aspect AdminTimesheetController_DailyTimesheetController {

    @RequestMapping(value = "/admin/timesheet/dailytimesheet", method = RequestMethod.POST)    
    public String AdminTimesheetController.createDailyTimesheet(@Valid DailyTimesheet dailyTimesheet, BindingResult result, ModelMap modelMap) {    
        if (dailyTimesheet == null) throw new IllegalArgumentException("A dailytimesheet is required");        
        if (!dailyTimesheet.getTimesheet().getSheetMonth().equals(DateUtils.getMonthInteger(dailyTimesheet.getDayDate()))) {
        	result.rejectValue("dayDate", "error.time.day.date.not.match");
        }
        if (StringUtils.hasText(dailyTimesheet.getProjectName())) {
        	logger.debug("Recieved project name: " + dailyTimesheet.getProjectName());
        	try {
        		Project project = projectService.loadOrCreateProject(dailyTimesheet.getProjectName());
        		dailyTimesheet.setProject(project);
        	} catch (Exception e) {
        		logger.error("", e);
        		result.rejectValue("projectName", "error.resourcenotfound.problemdescription");
        	}
        } else {
        	result.rejectValue("projectName", "field.required");
        }
        if (result.hasErrors()) {        
            modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(dailyTimesheet.getTimesheet().getEmployee()).getResultList());            
            return "admin/timesheet/dailytimesheet/create";            
        }
        
        dailyTimesheet = dailyTimesheetService.createDailyTimesheet(dailyTimesheet);    
        return "redirect:/admin/timesheet/dailytimesheet/" + dailyTimesheet.getId();        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailytimesheet/form/{timesheetId}", method = RequestMethod.GET)    
    public String AdminTimesheetController.createFormDailyTimesheet(@PathVariable("timesheetId") Long timesheetId, ModelMap modelMap) {
    	Timesheet timesheet = Timesheet.findTimesheet(timesheetId);  
    	DailyTimesheet dailyTimesheet = new DailyTimesheet();
    	dailyTimesheet.setTimesheet(timesheet);
    	dailyTimesheet.setDurationOffs(0f);
    	dailyTimesheet.setDurationTraining(0f);
    	//select first day for related year and month.
    	dailyTimesheet.setDayDate(DateUtils.getFirstDateOfRelatedYearAndMonth(timesheet));
        modelMap.addAttribute("dailyTimesheet", dailyTimesheet);        
        modelMap.addAttribute("timesheets", getListByOnlyOneTimesheet(timesheet));        
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
        if (!dailyTimesheet.getTimesheet().getSheetMonth().equals(DateUtils.getMonthInteger(dailyTimesheet.getDayDate()))) {
        	result.rejectValue("timesheet", "error.time.day.date.not.match");
        }
        if (StringUtils.hasText(dailyTimesheet.getProjectName())) {
        	logger.debug("Recieved project name: " + dailyTimesheet.getProjectName());
        	try {
        		Project project = projectService.loadOrCreateProject(dailyTimesheet.getProjectName());
        		dailyTimesheet.setProject(project);
        	} catch (Exception e) {
        		logger.error("", e);
        		result.rejectValue("projectName", "field.invalid");
        	}
        } else {
        	result.rejectValue("projectName", "field.required");
        }
        if (result.hasErrors()) {        
            modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(dailyTimesheet.getTimesheet().getEmployee()).getResultList());            
            return "admin/timesheet/dailytimesheet/update";            
        }        
        dailyTimesheetService.updateDailyTimesheet(dailyTimesheet);
        return "redirect:/admin/timesheet/dailytimesheet/" + dailyTimesheet.getId();        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailytimesheet/{id}/form", method = RequestMethod.GET)    
    public String AdminTimesheetController.updateFormDailyTimesheet(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        DailyTimesheet dailyTimesheet = DailyTimesheet.findDailyTimesheet(id);
        dailyTimesheet.setProjectName(dailyTimesheet.getProject().toString());
        modelMap.addAttribute("dailyTimesheet", dailyTimesheet);        
        modelMap.addAttribute("timesheets", Timesheet.findTimesheetsByEmployee(dailyTimesheet.getTimesheet().getEmployee()).getResultList());        
        return "admin/timesheet/dailytimesheet/update";        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailytimesheet/{id}", method = RequestMethod.DELETE)    
    public String AdminTimesheetController.deleteDailyTimesheet(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        DailyTimesheet dailyTimesheet = DailyTimesheet.findDailyTimesheet(id);  
        Long timesheetId = dailyTimesheetService.deleteDailyTimesheet(dailyTimesheet);
        return "redirect:/admin/timesheet/daily/" + timesheetId;        
    }    
    
    @RequestMapping(value = "/admin/timesheet/dailytimesheet/{timesheetId}/report/{format}" , method = RequestMethod.GET)
    public String AdminTimesheetController.reportDailyTimesheet(@PathVariable("timesheetId")Long timesheetId, @PathVariable("format") String format, ModelMap modelMap, HttpServletRequest request) {
    	Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
    	JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(timesheet.getDailyTimesheetsSortedList(),false);
    	modelMap.put("timesheetDailyReportList", jrDataSource);
    	
		// Fill ProjectSubReport
		List<DailyTimesheet> dts = dailyTimesheetService.getDailyTimesheetListForReportPerProject(timesheetId);
		modelMap.put("ProjectSubReportData", new JRBeanCollectionDataSource(dts, false));
    	
    	modelMap.put("format", format);
    	modelMap.put(Constants.IMAGE_HM_LOGO, getFileFullPath(request, Constants.imageHMlogoAddress));
    	return "timesheetDailyReportList";
    }
    
    @RequestMapping(value = "/admin/timesheet/dailytimesheet/percustomer/report" , method = RequestMethod.POST)
    public String AdminTimesheetController.reportDailyTimesheetPerCustomer(@Valid TimesheetDailyReportFormBean timesheetDailyReportFormBean, ModelMap modelMap, HttpServletRequest request) {
    	if (timesheetDailyReportFormBean == null) throw new IllegalArgumentException("A timesheetDailyReportFormBean is required"); 
    	Timesheet timesheet = Timesheet.findTimesheet(timesheetDailyReportFormBean.getTimesheetId());
    	List<DailyTimesheet> dailytimesheets = new ArrayList<DailyTimesheet>();
    	for (DailyTimesheet dt : timesheet.getDailyTimesheetsSortedList()) {
			if (timesheetDailyReportFormBean.getCustomer().equals(dt.getProject().getCustomer())) {
				dailytimesheets.add(dt);
			}
		}
    	JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(dailytimesheets,false);
    	modelMap.put("timesheetDailyReportList", jrDataSource);
    	modelMap.put("format", timesheetDailyReportFormBean.getFormat());
    	modelMap.put(Constants.IMAGE_HM_LOGO, getFileFullPath(request, Constants.imageHMlogoAddress));
    	return "timesheetDailyReportList";
    }
    
    private List<Timesheet> AdminTimesheetController.getListByOnlyOneTimesheet(Timesheet timesheet) {
    	List<Timesheet> timesheets = new ArrayList<Timesheet>();
    	timesheets.add(timesheet);
    	return timesheets;
    }
}
