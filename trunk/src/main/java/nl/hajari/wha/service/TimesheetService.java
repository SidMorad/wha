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
	 * @param timesheet
	 * @return
	 */
	Double calculateTotalAmountInvoice(Timesheet timesheet);

	/**
	 * @return
	 */
	List<Integer> findAllTimesheetYears();

}