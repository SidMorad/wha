/*
 * Created on Jan 30, 2010 - 6:07:42 PM
 */
package nl.hajari.wha.service;

import java.util.List;

import nl.hajari.wha.domain.DailyTimesheet;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public interface DailyTimesheetService {

	/**
	 * @param dailyTimesheet
	 * @param timesheetId
	 * @return
	 */
	DailyTimesheet createDailyTimesheet(DailyTimesheet dailyTimesheet, Long timesheetId);

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
	 * @param timesheetId
	 * @return
	 */
	boolean validateDailyHours(DailyTimesheet dailyTimesheet, Long timesheetId);

}
