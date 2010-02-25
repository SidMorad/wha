/*
 * Created on Feb 25, 2010 - 10:54:43 AM
 */
package nl.hajari.wha.service.impl;

import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.TimesheetService;

import org.springframework.stereotype.Service;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
@Service
public class TimesheetServiceImpl extends AbstractService implements TimesheetService {

	@Override
	public Timesheet load(Long id) {
		return Timesheet.findTimesheet(id);
	}

	@Override
	public void update(Timesheet timesheet) {
		timesheet.merge();
	}

	@Override
	public Double calculateTotalAmountInvoice(Timesheet timesheet) {
		// 1. Each employee should have an hourly wage
		// 2. Compute Total expense for others
		// 3. total travels of the month ratio
		// 4. tax rate
		// 5. bonus rate
		return 100.0;
	}

}
