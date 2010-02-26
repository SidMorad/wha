package nl.hajari.wha.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import nl.hajari.wha.Constants;
import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.Invoice;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.TimesheetService;
import nl.hajari.wha.service.impl.DailyExpenseServiceImpl;
import nl.hajari.wha.service.impl.DailyTimesheetServiceImpl;
import nl.hajari.wha.service.impl.LocaleAwareCalendarOptionsProvider;
import nl.hajari.wha.service.impl.ProjectServiceImpl;
import nl.hajari.wha.service.impl.TimesheetPossibleYearsOptionsProvider;
import nl.hajari.wha.web.controller.formbean.TimesheetDailyReportFormBean;
import nl.hajari.wha.web.controller.formbean.TimesheetYearMonthFormBean;
import nl.hajari.wha.web.util.DateUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminTimesheetController extends AbstractController {

	@Autowired
	protected DailyTimesheetServiceImpl dailyTimesheetService;

	@Autowired
	protected ProjectServiceImpl projectService;

	@Autowired
	protected DailyExpenseServiceImpl dailyExpenseService;

	@Autowired
	protected TimesheetService timesheetService;

	@Autowired
	protected TimesheetPossibleYearsOptionsProvider timesheetPossibleYearsOptionsProvider;

	@RequestMapping(value = "/admin/timesheet", method = RequestMethod.GET)
	public String listTimesheetAll(@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
		if (page != null || size != null) {
			int sizeNo = size == null ? 10 : size.intValue();
			modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByYearAndMonth(page == null ? 0 : (page
					.intValue() - 1)
					* sizeNo, sizeNo, null, null));
			float nrOfPages = (float) Timesheet.countTimesheets() / sizeNo;
			modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1
					: nrOfPages));
		} else {
			// -1 will ignore pagination and null will replace with current Year
			// and Month
			modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByYearAndMonth(-1, -1, null, null));
		}
		modelMap.addAttribute("timesheetYearMonthFormBean", new TimesheetYearMonthFormBean(DateUtils.getCurrentYear(),
				DateUtils.getCurrentMonth()));
		modelMap.addAttribute(LocaleAwareCalendarOptionsProvider.POSSIBLE_TIMESHEET_MONTHS_KEY, calendarOptionsProvider
				.getOptions());
		modelMap.addAttribute(TimesheetPossibleYearsOptionsProvider.TIMESHEET_POSSIBLE_YEARS_KEY,
				timesheetPossibleYearsOptionsProvider.getOptions());
		return "admin/timesheet/list";
	}

	@RequestMapping(value = "/admin/timesheet/refresh", method = { RequestMethod.POST, RequestMethod.GET })
	public String listTimesheetByYearAndMonth(TimesheetYearMonthFormBean yearMonthFormBean,
			@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
		if (page != null || size != null) {
			int sizeNo = size == null ? 10 : size.intValue();
			modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByYearAndMonth(page == null ? 0 : (page
					.intValue() - 1)
					* sizeNo, sizeNo, yearMonthFormBean.getYear(), yearMonthFormBean.getMonth()));
			float nrOfPages = (float) Timesheet.countTimesheets() / sizeNo;
			modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1
					: nrOfPages));
		} else {
			// -1 will ignore pagination and null will replace with current Year
			// and Month
			modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByYearAndMonth(-1, -1, yearMonthFormBean
					.getYear(), yearMonthFormBean.getMonth()));
		}
		modelMap.addAttribute(LocaleAwareCalendarOptionsProvider.POSSIBLE_TIMESHEET_MONTHS_KEY, calendarOptionsProvider
				.getOptions());
		modelMap.addAttribute(TimesheetPossibleYearsOptionsProvider.TIMESHEET_POSSIBLE_YEARS_KEY,
				timesheetPossibleYearsOptionsProvider.getOptions());
		return "admin/timesheet/list";
	}

	@RequestMapping(value = "/admin/timesheet/daily/{id}", method = RequestMethod.GET)
	public String showTimesheetDaily(@PathVariable("id") Long id, ModelMap modelMap) {
		if (id == null)
			throw new IllegalArgumentException("An Identifier is required");
		modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));
		modelMap.addAttribute("timesheetDailyReportFormBean", new TimesheetDailyReportFormBean());
		modelMap.addAttribute("customers", Customer.findAllCustomers());
		return "admin/timesheet/daily/show";
	}

	@RequestMapping(value = "/admin/timesheet/travel/{id}", method = RequestMethod.GET)
	public String showTimesheetTravel(@PathVariable("id") Long id, ModelMap modelMap) {
		if (id == null)
			throw new IllegalArgumentException("An Identifier is required");
		modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));
		return "admin/timesheet/travel/show";
	}

	@RequestMapping(value = "/admin/timesheet/expense/{id}", method = RequestMethod.GET)
	public String showTimesheetExpense(@PathVariable("id") Long id, ModelMap modelMap) {
		if (id == null)
			throw new IllegalArgumentException("An Identifier is required");
		modelMap.addAttribute("timesheet", Timesheet.findTimesheet(id));
		return "admin/timesheet/expense/show";
	}

	@RequestMapping(value = "/admin/timesheet/ponumber/{id}", method = RequestMethod.GET)
	public String showTimesheetPoNumberForm(@PathVariable("id") Long id, ModelMap modelMap) {
		if (null == id) {
			throw new IllegalArgumentException("Timesheet ID is required");
		}
		modelMap.addAttribute("timesheet", timesheetService.load(id));
		return "admin/timesheet/ponumber";
	}

	@RequestMapping(value = "/admin/timsheet/ponumber/update", method = RequestMethod.POST)
	public String updateTimesheetPoNumber(Timesheet timesheet, BindingResult result, ModelMap modelMap,
			HttpServletRequest request) {
		if (null == timesheet.getId()) {
			throw new IllegalArgumentException("Timesheet ID is required.");
		}
		Timesheet updatedTimesheet = timesheetService.load(timesheet.getId());
		updatedTimesheet.setPoNumber(timesheet.getPoNumber());
		timesheetService.update(updatedTimesheet);
		return "redirect:/admin/timesheet?page=1&size=25";
	}

	@RequestMapping(value = "/admin/timesheet/invoice/{id}", method = RequestMethod.GET)
	public String showTimesheetInvoiceForm(@PathVariable("id") Long id, ModelMap modelMap) {
		if (null == id) {
			throw new IllegalArgumentException("Timesheet ID is required.");
		}
		Invoice invoice = new Invoice();
		Timesheet timesheet = timesheetService.load(id);
		invoice.setTimesheet(timesheet);
		modelMap.addAttribute("timesheet", timesheet);
		modelMap.addAttribute("invoice", invoice);
		return "admin/timesheet/invoice";
	}

	@RequestMapping(value = "/admin/timsheet/invoice/generate", method = RequestMethod.POST)
	public String generateTimesheetInvoice(Invoice invoice, BindingResult result, ModelMap modelMap,
			HttpServletRequest request) {

		Timesheet timesheet = timesheetService.load(invoice.getTimesheet().getId());
		invoice.setTimesheet(timesheet);

		Double timesheetTotalWorking = timesheet.getMonthlyTotal().doubleValue();
		Double timesheetTotalExpense = dailyExpenseService
				.getDailyExpenseTotalForOthers(invoice.getTimesheet().getId());
		Double timesheetTotalTravel = timesheet.getTotalTravelDistance();
		Double totalAmount = timesheetService.calculateTotalAmountInvoice(timesheet);

		String invoicePrefixId = DateUtils.getMonthAndYearString(invoice.getInvoiceDate());
		String invoiceId = invoicePrefixId + "-" + invoice.getSerialNumber();
		invoice.setId(invoiceId);
		String invoiceDate = DateUtils.formatDate(invoice.getInvoiceDate(), getMessage(Constants.DATE_PATTERN_KEY));

		List<Invoice> invoices = new ArrayList<Invoice>();
		invoices.add(invoice);
		JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(invoices, false);

		modelMap.put("invoiceId", invoiceId);
		modelMap.put("invoiceDate", invoiceDate);
		modelMap.put("totalAmount", totalAmount);
		modelMap.put("timesheetTotalExpense", timesheetTotalExpense);
		modelMap.put("timesheetTotalTravel", timesheetTotalTravel);
		modelMap.put("timesheetTotalWorking", timesheetTotalWorking);
		modelMap.put("timesheetInvoiceList", jrDataSource);
		modelMap.put("format", "pdf");
		modelMap.put(Constants.IMAGE_HM_LOGO, getFileFullPath(request, Constants.imageHMlogoAddress));
		modelMap.put("reportFileName", invoiceId + "___" + timesheet.getEmployee().toString().replaceAll(" ", ""));

		return "timesheetInvoiceList";
	}

	public String getFileFullPath(HttpServletRequest request, String filePath) {
		String appServerHome = request.getSession().getServletContext().getRealPath("/");
		return appServerHome + filePath;
	}

}