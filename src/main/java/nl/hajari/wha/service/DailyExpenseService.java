/*
 * Created on Jan 30, 2010 - 6:06:04 PM
 */
package nl.hajari.wha.service;

import java.util.List;

import nl.hajari.wha.domain.DailyExpense;
import nl.hajari.wha.domain.Timesheet;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public interface DailyExpenseService {

	/**
	 * @param timesheetId
	 * @return
	 */
	List<DailyExpense> getDailyExpensesForHajari(Long timesheetId);

	/**
	 * @param timesheetId
	 * @return
	 */
	List<DailyExpense> getDailyExpensesForOthers(Long timesheetId);

	/**
	 * 
	 * @param timesheet
	 * @return true if succeed
	 */
	boolean deleteDailyExpenseByTimesheet(Timesheet timesheet);

}
