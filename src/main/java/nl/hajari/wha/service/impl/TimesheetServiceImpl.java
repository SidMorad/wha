/*
 * Created on Feb 25, 2010 - 10:54:43 AM
 */
package nl.hajari.wha.service.impl;

import java.util.List;

import javax.persistence.Query;

import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.TimesheetService;

import org.springframework.stereotype.Service;

import com.sun.xml.internal.bind.v2.TODO;

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
	public List<Integer> findAllTimesheetYears() {
		Query q = Timesheet.findAllTimesheetYears();
		try {
			List<Integer> years = q.getResultList();
			return years;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public Double calculateTotalAmountInvoice(Timesheet timesheet) {
		//TODO:: 
		// 1. Each employee should have an hourly wage
		// 2. Compute Total expense for others
		// 3. total travels of the month ratio
		// 4. tax rate
		// 5. bonus rate
		return 100.0;
	}

}
