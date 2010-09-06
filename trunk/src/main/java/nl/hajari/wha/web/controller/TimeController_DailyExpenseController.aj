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
import nl.hajari.wha.web.util.DateUtils;

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
		// Long timesheetId = (Long) request.getSession().getAttribute(
		// Timesheet.TIMESHEET_ID);
		// if (timesheetId == null) {
		// throw new IllegalStateException(
		// "Month Expense view requires current Timesheet. Timesheet ID is null.");
		// }
		// Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		Timesheet timesheet = loadWorkingTimesheet(request);
		logger.debug("Timesheet Founded: [" + timesheet
				+ "] for Expense Month View");

		DailyExpense de = new DailyExpense();
		de.setTimesheet(timesheet);
		modelMap.put("dailyExpense", de);
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
		// Long timesheetId = (Long) request.getSession().getAttribute(
		// Timesheet.TIMESHEET_ID);
		// if (timesheetId == null) {
		// throw new IllegalStateException(
		// "Month Expense view requires current Timesheet. Timesheet ID is null.");
		// }
		// Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		Timesheet timesheet = Timesheet.findTimesheet(dailyExpense.getTimesheet().getId());
		logger.debug("Timesheet Founded: [" + timesheet
				+ "] for Expense Month View (Update)");
		Integer timesheetMonth = timesheet.getSheetMonth();
		Integer dailyTimesheetMonth = DateUtils.getMonthInteger(dailyExpense.getDayDate());
		if (!timesheetMonth.equals(dailyTimesheetMonth)) {
			result.rejectValue("dayDate", "error.time.day.date.not.avaiable");
		}
		
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
		request.setAttribute(Timesheet.TIMESHEET_ID, timesheet.getId());
		return prepareExpenseMonthView(request, modelMap);
	}

	@RequestMapping(value = "/time/expense/{id}", method = RequestMethod.GET)
	public String TimeController.prepareOpenTimesheetExpenseMonthView(@PathVariable("id") Long id,
			HttpServletRequest request,
			ModelMap mm) {
		request.setAttribute(Timesheet.TIMESHEET_ID, id);
		return prepareExpenseMonthView(request, mm);
	}

	@RequestMapping(value = "/time/expense/delete/{id}", method = RequestMethod.DELETE)
	public String TimeController.deleteDailyExpense(@PathVariable("id") Long id, HttpServletRequest request, ModelMap mm) {
		if (id == null)
			throw new IllegalArgumentException("An Identifier is required");
		DailyExpense de = DailyExpense.findDailyExpense(id);
		Long timesheetId = de.getTimesheet().getId();
		de.remove();
		de.flush();
		request.setAttribute(Timesheet.TIMESHEET_ID, timesheetId);
		return prepareExpenseMonthView(request, mm);
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
