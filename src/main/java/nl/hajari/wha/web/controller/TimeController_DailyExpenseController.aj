package nl.hajari.wha.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.DailyExpense;
import nl.hajari.wha.domain.Timesheet;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 **/
privileged aspect TimeController_DailyExpenseController {

	@RequestMapping(value = "/time/expense", method = RequestMethod.GET)
	public String TimeController.prepareExpenseMonthView(
			HttpServletRequest request, ModelMap modelMap) {
		Long timesheetId = (Long) request.getSession().getAttribute(
				Timesheet.TIMESHEET_ID);
		if (timesheetId == null) {
			throw new IllegalStateException(
					"Month Expense view requires current Timesheet. Timesheet ID is null.");
		}
		Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		logger.debug("Timesheet Founded: [" + timesheet
				+ "] for Expense Month View");

		modelMap.put("dailyExpense", new DailyExpense());
		modelMap.put("dailyExpenses", timesheet.getDailyExpensesSortedList());
		modelMap.put("timesheet", timesheet);
		modelMap.put("employee", timesheet.getEmployee());
		modelMap.put("customers", Customer.findAllCustomers());
		
		Customer defaultCustomer = customerService.findExpenseDefaultCustomer();
		modelMap.put("defaultCustomerId", defaultCustomer == null ? "-1" : defaultCustomer.getId());
		
		return "time/expense/month";
	}

	@RequestMapping(value = "/time/expense/update", method = RequestMethod.POST)
	public String TimeController.updateExpenseMonthView(
			@Valid DailyExpense dailyExpense, BindingResult result,
			HttpServletRequest request, ModelMap modelMap) {
		Long timesheetId = (Long) request.getSession().getAttribute(
				Timesheet.TIMESHEET_ID);
		if (timesheetId == null) {
			throw new IllegalStateException(
					"Month Expense view requires current Timesheet. Timesheet ID is null.");
		}
		Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		logger.debug("Timesheet Founded: [" + timesheet
				+ "] for Expense Month View (Update)");
		if (result.hasErrors()) {
			// Fill modelMap and return
			modelMap.put("dailyExpenses", timesheet
					.getDailyExpensesSortedList());
			modelMap.put("timesheet", timesheet);
			modelMap.put("employee", timesheet.getEmployee());
			modelMap.put("customers", Customer.findAllCustomers());
			return "time/expense/month";
		}
		dailyExpense.setTimesheet(timesheet);
		dailyExpense.persist();

		return prepareExpenseMonthView(request, modelMap);
	}

	@RequestMapping(value = "/time/expense/delete/{id}", method = RequestMethod.DELETE)
	public String TimeController.deleteDailyExpense(@PathVariable("id") Long id) {
		if (id == null)
			throw new IllegalArgumentException("An Identifier is required");
		DailyExpense.findDailyExpense(id).remove();
		return "redirect:/time/expense";
	}

}
