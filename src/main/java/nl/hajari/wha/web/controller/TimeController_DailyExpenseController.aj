package nl.hajari.wha.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import nl.hajari.wha.Constants;
import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.DailyExpense;
import nl.hajari.wha.domain.Timesheet;

import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

	@RequestMapping(value = "/time/timesheet/dailyexpense/{timesheetId}/reportforhajari/{format}", method = RequestMethod.GET)
	public String TimeController.reportDailyExpenseForHajari(
			@PathVariable("timesheetId") Long timesheetId,
			@PathVariable("format") String format, ModelMap modelMap,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		if (timesheetId == null)
			throw new IllegalArgumentException("An Identifier is required");
		authorizeAccessTimesheet(timesheetId, request, response);

		List<DailyExpense> dailyExpensesList = dailyExpenseService.getDailyExpensesForHajari(timesheetId); 
		JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(
				dailyExpensesList, false);
		modelMap.put("timesheetExpenseReportList", jrDataSource);
		modelMap.put("format", format);
		modelMap.put(Constants.IMAGE_HM_LOGO, getFileFullPath(request, Constants.imageHMlogoAddress));
		return "timesheetExpenseReportList";
	}

	@RequestMapping(value = "/time/timesheet/dailyexpense/{timesheetId}/reportforothers/{format}", method = RequestMethod.GET)
	public String TimeController.reportDailyExpenseForOthers(
			@PathVariable("timesheetId") Long timesheetId,
			@PathVariable("format") String format, ModelMap modelMap,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		if (timesheetId == null)
			throw new IllegalArgumentException("An Identifier is required");
		authorizeAccessTimesheet(timesheetId, request, response);
		
		List<DailyExpense> dailyExpensesList = dailyExpenseService.getDailyExpensesForOthers(timesheetId); 
		JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(
				dailyExpensesList, false);
		modelMap.put("timesheetExpenseForNotHajariReportList", jrDataSource);
		modelMap.put("format", format);
		modelMap.put(Constants.IMAGE_HM_LOGO, getFileFullPath(request, Constants.imageHMlogoAddress));
		return "timesheetExpenseForNotHajariReportList";
	}

}
