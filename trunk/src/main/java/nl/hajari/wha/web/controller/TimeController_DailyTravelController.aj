package nl.hajari.wha.web.controller;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import nl.hajari.wha.Constants;
import nl.hajari.wha.domain.DailyTravel;
import nl.hajari.wha.domain.Timesheet;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 **/
privileged aspect TimeController_DailyTravelController {

	@RequestMapping(value = "/time/travel", method = RequestMethod.GET)
	public String TimeController.prepareTravelMonthView(HttpServletRequest request, ModelMap modelMap) {
		Long timesheetId = (Long) request.getSession().getAttribute(Timesheet.TIMESHEET_ID);
		if (timesheetId == null) {
			throw new IllegalStateException("Month Travel view requires current Timesheet. Timesheet ID is null.");
		}
		Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		logger.debug("Timesheet Founded: [" + timesheet + "] for Travel Month View");
		
		modelMap.put("dailyTravel", new DailyTravel());
		modelMap.put("dailyTravels", timesheet.getDailyTravelsSortedList());
		modelMap.put("timesheet", timesheet);
		modelMap.put("employee", timesheet.getEmployee());
		return "time/travel/month";
	}
	
	@RequestMapping(value = "/time/travel/update", method = RequestMethod.POST)
	public String TimeController.updateTravelMonthView(@Valid DailyTravel dailyTravel,
			BindingResult result, HttpServletRequest request, ModelMap modelMap) {
		if (dailyTravel == null) {
			throw new IllegalArgumentException("DailyTravel is null.");
		}
		Long timesheetId = (Long) request.getSession().getAttribute(Timesheet.TIMESHEET_ID);
		Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		
		if (result.hasErrors()) {
			// Fill modelMap and return
			modelMap.put("dailyTravels", timesheet.getDailyTravelsSortedList());
			modelMap.put("timesheet", timesheet);
			modelMap.put("employee", timesheet.getEmployee());
			return "time/travel/month";
		}
		
		dailyTravel.setTimesheet(timesheet);
		dailyTravel.persist();
		
		return prepareTravelMonthView(request, modelMap);
	}

    @RequestMapping(value = "/time/travel/delete/{id}", method = RequestMethod.DELETE)    
    public String TimeController.deleteDailyTravel(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        DailyTravel.findDailyTravel(id).remove();        
        return "redirect:/time/travel";
    }    

	@RequestMapping(value = "/time/timesheet/dailytravel/{timesheetId}/report/{format}", method = RequestMethod.GET)
	public String TimeController.reportDailyTravel(
			@PathVariable("timesheetId") Long timesheetId,
			@PathVariable("format") String format, ModelMap modelMap,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		if (timesheetId == null)
			throw new IllegalArgumentException("An Identifier is required");
		authorizeAccessTimesheet(timesheetId, request, response);
		Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		Set<DailyTravel> dailyTravels = timesheet.getDailyTravels();
		double totalDistance = 0.0;
		for (DailyTravel dt : dailyTravels) {
			totalDistance += dt.getWithReturn() ? dt.getDistance() * 2 : dt.getDistance(); 
		}
		JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(
				timesheet.getDailyTravelsSortedList(), false);

		
		modelMap.put("timesheetTravelReportList", jrDataSource);
		modelMap.put("format", format);
		modelMap.put(Constants.IMAGE_HM_LOGO, getFileFullPath(request, Constants.imageHMlogoAddress));
		modelMap.put("total_distance", totalDistance + "");
		return "timesheetTravelReportList";
	}
}
