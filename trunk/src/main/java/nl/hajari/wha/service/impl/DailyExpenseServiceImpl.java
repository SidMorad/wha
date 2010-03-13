package nl.hajari.wha.service.impl;

import java.util.ArrayList;
import java.util.List;

import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.DailyExpense;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.DailyExpenseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
@Service
public class DailyExpenseServiceImpl extends AbstractService implements DailyExpenseService {

	@Autowired
	CustomerServiceImpl customerService;

	public List<DailyExpense> getDailyExpensesForHajari(Long timesheetId) {
		Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		Customer defaultCustomer = customerService.findExpenseDefaultCustomer();
		List<DailyExpense> hajariList = new ArrayList<DailyExpense>();
		for (DailyExpense de : timesheet.getDailyExpensesSortedList()) {
			if (defaultCustomer.equals(de.getCustomer())) {
				hajariList.add(de);
			}
		}
		return hajariList;
	}

	public List<DailyExpense> getDailyExpensesForOthers(Long timesheetId) {
		Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		Customer defaultCustomer = customerService.findExpenseDefaultCustomer();
		List<DailyExpense> notHajariList = new ArrayList<DailyExpense>();
		for (DailyExpense de : timesheet.getDailyExpensesSortedList()) {
			if (!defaultCustomer.equals(de.getCustomer())) {
				notHajariList.add(de);
			}
		}
		return notHajariList;
	}

	public Double getDailyExpenseTotalForOthers(Long timesheetId) {
		List<DailyExpense> dailyExpensesForOthers = getDailyExpensesForOthers(timesheetId);
		double total = 0.0;
		if (null == dailyExpensesForOthers || dailyExpensesForOthers.isEmpty()) {
			return total;
		}
		for (DailyExpense de : dailyExpensesForOthers) {
			total += de.getExpenseAmount();
		}
		return total;
	}

	public Float calculateDailyExpenseTotalForHajari(Long timesheetId) {
		List<DailyExpense> dailyExpenses = getDailyExpensesForHajari(timesheetId);
		float total = 0;
		if (null == dailyExpenses || dailyExpenses.isEmpty()) {
			return total;
		}
		for (DailyExpense de : dailyExpenses) {
			total += de.getExpenseAmount();
		}
		return total;
	}
}
