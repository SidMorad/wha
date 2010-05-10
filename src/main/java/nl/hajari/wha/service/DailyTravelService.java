/*
 * Created on 13/03/2010 - 2:37:09 PM 
 */
package nl.hajari.wha.service;

import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.web.controller.formbean.TimesheetWeeklyFormBean;

/**
 * 
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 * @author Behrooz Nobakht
 */
public interface DailyTravelService {

	/**
	 * 
	 * @param timesheetId
	 * @return travelTotalDistance
	 */
	Float calculateTravelTotalDistance(Long timesheetId);

	/**
	 * 
	 * @param timesheet
	 * @return true if succeed .
	 */
	boolean deleteDailyTravelByTimesheet(Timesheet timesheet);

	/**
	 * @param bean
	 * @param timesheet
	 */
	void saveOrUpdateWeeklyTravels(TimesheetWeeklyFormBean bean, Timesheet timesheet);
}
