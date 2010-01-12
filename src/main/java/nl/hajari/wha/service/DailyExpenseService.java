package nl.hajari.wha.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.DailyExpense;
import nl.hajari.wha.domain.Timesheet;

/**
 *
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>	
 */
@Service
public class DailyExpenseService {

	@Autowired
	CustomerService customerService;
	
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
}
