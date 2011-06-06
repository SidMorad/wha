/*
 * Created on Jan 30, 2010 - 6:07:42 PM
 */
package nl.hajari.wha.service;

import java.util.Date;
import java.util.List;

import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.web.controller.formbean.TimesheetWeeklyFormBean;

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
	 * @param employee
	 * @param from
	 * @param to
	 * @return
	 */
	List<DailyTimesheet> getDailyTimesheetListPerProject(Employee employee, Date from, Date to);

	/**
	 * @param dailyTimesheet
	 * @param timesheetId
	 * @return
	 */
	boolean validateDailyHours(DailyTimesheet dailyTimesheet, Long timesheetId);

	/**
	 * 
	 * @param timesheet
	 * @return true if succeed
	 */
	boolean deleteDailyTimesheetByTimesheet(Timesheet timesheet);

	/**
	 * @param bean
	 * @param timesheet
	 * @param project
	 */
	void saveOrUpdateWeeklyTimesheet(TimesheetWeeklyFormBean bean, Timesheet timesheet, Project project);

}
