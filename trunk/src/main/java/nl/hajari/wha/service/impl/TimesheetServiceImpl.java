/*
 * Created on Feb 25, 2010 - 10:54:43 AM
 */
package nl.hajari.wha.service.impl;

import java.util.List;

import javax.persistence.Query;

import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.ConstantsService;
import nl.hajari.wha.service.DailyExpenseService;
import nl.hajari.wha.service.DailyTimesheetService;
import nl.hajari.wha.service.DailyTravelService;
import nl.hajari.wha.service.InvoiceService;
import nl.hajari.wha.service.TimesheetService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
@Service
public class TimesheetServiceImpl extends AbstractService implements TimesheetService {

	@Autowired
	protected DailyTimesheetService dailyTimesheetService;

	@Autowired
	protected DailyTravelService dailyTravelService;

	@Autowired
	protected DailyExpenseService dailyExpenseService;

	@Autowired
	protected InvoiceService invoiceService;

	@Autowired
	protected ConstantsService constantsService;

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
	@Transactional
	public boolean delete(Long id) {
		Timesheet timesheet = load(id);
		dailyTimesheetService.deleteDailyTimesheetByTimesheet(timesheet);
		dailyTravelService.deleteDailyTravelByTimesheet(timesheet);
		dailyExpenseService.deleteDailyExpenseByTimesheet(timesheet);
		logService.deleteLogByTimesheet(timesheet);
		invoiceService.deleteInvoiceByTimesheet(timesheet);
		timesheet.remove();
		return true;
	}

	@Override
	public void archive(Long id) {
		Timesheet timesheet = load(id);
		timesheet.setArchived(true);
		timesheet.merge();
	}

	@Override
	public void archiveUndo(Long id) {
		Timesheet timesheet = load(id);
		timesheet.setArchived(false);
		timesheet.merge();
	}

	@Override
	public Double getTotalPayableAmount(Timesheet timesheet) {
		return calculateTotalWorkingAmountPayable(timesheet) + calculateTotalExpenseAmountPayable(timesheet);
	}

	/**
	 * @see {@link TimesheetService#calculateTotalWorkingAmountPayable(Timesheet)}
	 */
	@Override
	public Double calculateTotalWorkingAmountPayable(Timesheet timesheet) {
		Double thm = timesheet.getMonthlyTotalWorkingHours().doubleValue();
		Float hwe = timesheet.getEmployee().getHourlyWage();
		Float cmc = 0f;
		Double total = thm * hwe + cmc;
		return total;
	}

	/**
	 * @see {@link TimesheetService#calculateTotalExpenseAmountPayable(Timesheet)}
	 */
	@Override
	public Double calculateTotalExpenseAmountPayable(Timesheet timesheet) {
		Double tkm = timesheet.getTotalTravelDistance();
		Float perKilometerRatio = getPerKilometerRatio();
		Double tem = timesheet.getTotalExpense();
		Double total = tkm * perKilometerRatio + tem;
		return total;
	}

	@Override
	public Double calculateVatTax(Double amount) {
		return amount.doubleValue() * getVatRatio();
	}

	private Float getVatRatio() {
		return Float.valueOf(constantsService.findValue(ConstantsService.CONST_KEY_EXPENSE_VAT));
	}

	private Float getPerKilometerRatio() {
		return Float.valueOf(constantsService.findValue(ConstantsService.CONST_KEY_EXPENSE_GAS_SUBSIDY_PER_KILOMETER));
	}

}
