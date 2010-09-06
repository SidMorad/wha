/*
 * Created on Feb 25, 2010 - 10:54:09 AM
 */
package nl.hajari.wha.service;

import java.util.List;

import nl.hajari.wha.domain.Timesheet;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public interface TimesheetService {

	/**
	 * @param id
	 * @return
	 */
	Timesheet load(Long id);

	/**
	 * @param timesheet
	 */
	void update(Timesheet timesheet);

	/**
	 * The formula is:
	 * 
	 * total = THM * HWE + THM * HWE * VAT_RATIO + CMC
	 * 
	 * in which:
	 * 
	 * <p>
	 * THM = Total hours of work in a month for the employee
	 * <p>
	 * WHE = Hourly wage for the employee
	 * <p>
	 * VAT_RATIO = is the VAT ration which is defined in the constants table of
	 * WHA
	 * <p>
	 * CMC = is some constant costs (IGNORE THIS AT THE MOMENT)
	 * 
	 * @param timesheet
	 * @return the total payable amount computed with above formula
	 */
	Double calculateTotalWorkingAmountPayable(Timesheet timesheet);

	/**
	 * The formula is:
	 * 
	 * total = (TKM * KM_RATIO + TEM) * (1 + VAT_RATIO)
	 * 
	 * in which:
	 * 
	 * <p>
	 * TKM = Total kilometers in for the timesheet that has a PO Number
	 * <p>
	 * KM_RATIO = the ratio of euros per kilometer which is defined in the
	 * constant section of WHA
	 * <p>
	 * TEM = total expesnes in a month for the timesheet
	 * <p>
	 * VAT_RATIO = the same as
	 * {@link #calculateTotalExpenseAmountPayable(Timesheet)}
	 * 
	 * @param timesheet
	 * @return the total payable amount computed with above formula
	 */
	Double calculateTotalExpenseAmountPayable(Timesheet timesheet);

	/**
	 * 
	 * 
	 * @param timesheet
	 * @return the sum of {@link #calculateTotalWorkingAmountPayable(Timesheet)}
	 *         and {@link #calculateTotalExpenseAmountPayable(Timesheet)}
	 */
	Double getTotalPayableAmount(Timesheet timesheet);

	/**
	 * It is a simple calculation based on
	 * {@link ConstantsService#CONST_KEY_EXPENSE_VAT}
	 * 
	 * @param amount
	 * @return
	 */
	Double calculateVatTax(Double amount);

	/**
	 * @return
	 */
	List<Integer> findAllTimesheetYears();

	/**
	 * 
	 * @param id
	 * @return true if success .
	 */
	boolean delete(Long id);

	/**
	 * 
	 * @param id
	 */
	void archive(Long id);

	/**
	 * 
	 * @param id
	 */
	void archiveUndo(Long id);

	/**
	 * Makes the timesheet editable for the employee even if it is not the
	 * month.
	 * 
	 * @param id
	 */
	void openTimesheetForEmployee(Long id);

	/**
	 * Closes a timesheet not to be editable for employee.
	 * 
	 * @param id
	 */
	void closeTimesheetForEmployee(Long id);

	/**
	 * Finds the open (editable) time sheets for some employee.
	 * 
	 * @param employeeId
	 * @return
	 */
	List<Timesheet> findEditableTimesheets(Long employeeId);

}
