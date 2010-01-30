/*
 * Created on Jan 30, 2010 - 6:07:42 PM
 */
package nl.hajari.wha.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import nl.hajari.wha.domain.DailyTimesheet;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public interface DailyTimesheetService {

	/**
	 * 
	 * 
	 * @param dailyTimesheet
	 * @param request
	 * @return
	 */
	// TODO why HttpRequest is appeared in service layer?
	DailyTimesheet createDailyTimesheet(DailyTimesheet dailyTimesheet,
			HttpServletRequest request);

	/**
	 * @param dailyTimesheet
	 * @return
	 */
	DailyTimesheet createDailyTimesheet(DailyTimesheet dailyTimesheet);

	/**
	 * @param dailyTimesheet
	 * @return
	 */
	DailyTimesheet updateDailyTimesheet(DailyTimesheet dailyTimesheet);

	/**
	 * @param dailyTimesheet
	 * @return
	 */
	Long deleteDailyTimesheet(DailyTimesheet dailyTimesheet);

	/**
	 * @param timesheetId
	 * @return
	 */
	List<DailyTimesheet> getDailyTimesheetListForReportPerProject(Long timesheetId);

	/**
	 * @param dailyTimesheet
	 * @param request
	 * @return
	 */
	// TODO better name? such as 'validate'? and maybe the 'validate' may
	// delegate to different method in different implementations
	boolean checkIfDurationIsMoreThan24(DailyTimesheet dailyTimesheet, HttpServletRequest request);

}
