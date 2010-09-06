package nl.hajari.wha.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import nl.hajari.wha.Constants;
import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Invoice;
import nl.hajari.wha.domain.InvoiceType;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.ConstantsService;
import nl.hajari.wha.service.DailyTravelService;
import nl.hajari.wha.service.InvoiceService;
import nl.hajari.wha.service.TimesheetService;
import nl.hajari.wha.service.impl.DailyExpenseServiceImpl;
import nl.hajari.wha.service.impl.DailyTimesheetServiceImpl;
import nl.hajari.wha.service.impl.LocaleAwareCalendarOptionsProvider;
import nl.hajari.wha.service.impl.ProjectServiceImpl;
import nl.hajari.wha.service.impl.TimesheetPossibleYearsOptionsProvider;
import nl.hajari.wha.web.controller.formbean.TimesheetDailyReportFormBean;
import nl.hajari.wha.web.controller.formbean.TimesheetYearMonthFormBean;
import nl.hajari.wha.web.util.DateUtils;
import nl.hajari.wha.web.util.MathUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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

	@Autowired
	protected InvoiceService invoiceService;

	@Autowired
	protected DailyTravelService dailyTravelService;

	@Autowired
	protected ConstantsService constantsService;

	@RequestMapping(value = "/admin/timesheet", method = RequestMethod.GET)
	public String listTimesheetAll(@RequestParam(value = "page", required = false) Integer page,
			@RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
		if (page != null || size != null) {
			int sizeNo = size == null ? 10 : size.intValue();
			modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByYearAndMonth(page == null ? 0 : (page
					.intValue() - 1)
					* sizeNo, sizeNo, null, null, false));
			float nrOfPages = (float) Timesheet.countTimesheets() / sizeNo;
			modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1
					: nrOfPages));
		} else {
			// -1 will ignore pagination and null will replace with current Year
			// and Month
			modelMap
					.addAttribute("timesheets", Timesheet.findTimesheetEntriesByYearAndMonth(-1, -1, null, null, false));
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
					* sizeNo, sizeNo, yearMonthFormBean.getYear(), yearMonthFormBean.getMonth(), yearMonthFormBean
					.isArchived()));
			float nrOfPages = (float) Timesheet.countTimesheets() / sizeNo;
			modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1
					: nrOfPages));
		} else {
			// -1 will ignore pagination
			modelMap.addAttribute("timesheets", Timesheet.findTimesheetEntriesByYearAndMonth(-1, -1, yearMonthFormBean
					.getYear(), yearMonthFormBean.getMonth(), yearMonthFormBean.isArchived()));
		}
		modelMap.addAttribute(LocaleAwareCalendarOptionsProvider.POSSIBLE_TIMESHEET_MONTHS_KEY, calendarOptionsProvider
				.getOptions());
		modelMap.addAttribute(TimesheetPossibleYearsOptionsProvider.TIMESHEET_POSSIBLE_YEARS_KEY,
				timesheetPossibleYearsOptionsProvider.getOptions());
		return "admin/timesheet/list";
	}

	@RequestMapping(value = "/admin/timesheet/redirect", method = RequestMethod.GET)
	public String listTimesheetByYearAndMonth(ModelMap modelMap,
			@RequestParam(value = "year", required = true) Integer year,
			@RequestParam(value = "month", required = true) Integer month,
			@RequestParam(value = "archived", required = false) boolean archived) {
		modelMap
				.addAttribute("timesheets", Timesheet.findTimesheetEntriesByYearAndMonth(-1, -1, year, month, archived));
		modelMap.addAttribute(LocaleAwareCalendarOptionsProvider.POSSIBLE_TIMESHEET_MONTHS_KEY, calendarOptionsProvider
				.getOptions());
		modelMap.addAttribute(TimesheetPossibleYearsOptionsProvider.TIMESHEET_POSSIBLE_YEARS_KEY,
				timesheetPossibleYearsOptionsProvider.getOptions());
		modelMap.addAttribute("timesheetYearMonthFormBean", new TimesheetYearMonthFormBean(year, month, archived));
		return "admin/timesheet/list";
	}

	@RequestMapping(value = "/admin/timesheet/delete/{id}")
	public String deleteTimesheet(@PathVariable("id") Long id) {
		Timesheet timesheet = timesheetService.load(id);
		timesheetService.delete(id);
		return "redirect:/admin/timesheet/redirect?year=" + timesheet.getSheetYear() + "&month="
				+ timesheet.getSheetMonth() + "&archived=" + timesheet.isArchived();
	}

	@RequestMapping(value = "/admin/timesheet/archive/{id}")
	public String archiveTimesheet(@PathVariable("id") Long id) {
		Timesheet timesheet = timesheetService.load(id);
		timesheetService.archive(id);
		return "redirect:/admin/timesheet/redirect?year=" + timesheet.getSheetYear() + "&month="
				+ timesheet.getSheetMonth() + "&archived=" + false;
	}

	@RequestMapping(value = "/admin/timesheet/archive/undo/{id}")
	public String archiveUndoTimesheet(@PathVariable("id") Long id) {
		Timesheet timesheet = timesheetService.load(id);
		timesheetService.archiveUndo(id);
		return "redirect:/admin/timesheet/redirect?year=" + timesheet.getSheetYear() + "&month="
				+ timesheet.getSheetMonth() + "&archived=" + true;
	}

	@RequestMapping(value = "/admin/timesheet/open/{id}", method = RequestMethod.GET)
	public String openTimesheet(@PathVariable("id") Long id) {
		timesheetService.openTimesheetForEmployee(id);
		Timesheet timesheet = timesheetService.load(id);
		return "redirect:/admin/timesheet/redirect?year=" + timesheet.getSheetYear() + "&month="
				+ timesheet.getSheetMonth() + "&archived=false";
	}

	@RequestMapping(value = "/admin/timesheet/close/{id}", method = RequestMethod.GET)
	public String closeTimesheet(@PathVariable("id") Long id) {
		timesheetService.closeTimesheetForEmployee(id);
		Timesheet timesheet = timesheetService.load(id);
		return "redirect:/admin/timesheet/redirect?year=" + timesheet.getSheetYear() + "&month="
				+ timesheet.getSheetMonth() + "&archived=false";
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
		Timesheet timesheet = timesheetService.load(id);
		Invoice invoice = invoiceService.loadByTimesheet(timesheet);
		if (null == invoice) {
			invoice = new Invoice();
		}
		invoice.setTimesheet(timesheet);
		modelMap.addAttribute("timesheet", timesheet);
		modelMap.addAttribute("invoice", invoice);
		modelMap.addAttribute("invoicetype_enum", InvoiceType.class.getEnumConstants());
		return "admin/timesheet/invoice";
	}

	@Transactional
	@RequestMapping(value = "/admin/timsheet/invoice/generate", method = RequestMethod.POST)
	public String generateTimesheetInvoice(Invoice invoice, BindingResult result, ModelMap modelMap,
			HttpServletRequest request) {
		Timesheet timesheet = timesheetService.load(invoice.getTimesheet().getId());
		invoice.setTimesheet(timesheet);
		if (result.hasErrors()) {
			modelMap.addAttribute("timesheet", timesheet);
			modelMap.addAttribute("invoice", invoice);
			modelMap.addAttribute("invoicetype_enum", InvoiceType.class.getEnumConstants());
			return "admin/timesheet/invoice";
		}
		modelMap.put("reportHeadered", invoice.getReportHeadered());
		if (invoice.getInvoiceType().equals(InvoiceType.timesheet)) {
			return generateTimesheetInvoiceForTimesheet(invoice, modelMap,
					result, request);
		} else {
			// If InvoiceType is not InvoiceType.timesheet then it only can be
			// InvoiceType.expense .
			return generateTimesheetInvoiceForExpense(invoice, modelMap,
					result, request);
		}
	}

	private String generateTimesheetInvoiceForTimesheet(Invoice invoice,
			ModelMap modelMap, BindingResult result, HttpServletRequest request) {
		Double timesheetTotalWorking = invoice.getTimesheet().getMonthlyTotal().doubleValue();

		String invoicePrefixId = DateUtils.getMonthAndYearString(invoice.getInvoiceDate());
		String invoiceId = invoicePrefixId + "-" + invoice.getSerialNumber();
		invoice.setInvoiceId(invoiceId);
		String invoiceDate = DateUtils.formatDate(invoice.getInvoiceDate(), getMessage(Constants.DATE_PATTERN_KEY));

		// Persist Invoice entity
		invoice = invoiceService.saveOrUpdate(invoice);
		Timesheet timesheet = timesheetService.load(invoice.getTimesheet().getId());

		List<Invoice> invoices = new ArrayList<Invoice>();
		invoices.add(invoice);
		JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(invoices, false);

		modelMap.put("invoiceDate", invoiceDate);
		modelMap.put("onkosten", 0.0);
		modelMap.put("timesheetTotalWorking", timesheetTotalWorking);
		modelMap.put("timesheetInvoiceList", jrDataSource);
		modelMap.put("format", "pdf");
		modelMap.put(Constants.IMAGE_HM_LOGO, getFileFullPath(request, Constants.imageHMlogoAddress));
		modelMap.put("reportFileName", "FAK-" + invoiceId);

		// Fill ProjectSubReport
		List<DailyTimesheet> dts = dailyTimesheetService.getDailyTimesheetListForReportPerProject(invoice
				.getTimesheet().getId());
		modelMap.put("ProjectSubReportData", new JRBeanCollectionDataSource(dts, false));

		// Calacuate subtotal
		Double subTotal = timesheetService.calculateTotalWorkingAmountPayable(timesheet);
		modelMap.put("subTotal", MathUtils.roundToTwoDecimalPlaces(subTotal));

		// VAT Tax
		Double timesheetTotalTax = timesheetService.calculateVatTax(subTotal);
		modelMap.put("timesheetTotalTax", MathUtils.roundToTwoDecimalPlaces(timesheetTotalTax));

		Double totalAmount = subTotal + timesheetTotalTax;
		modelMap.put("totalAmount", MathUtils.roundToTwoDecimalPlaces(totalAmount));

		return "timesheetInvoiceList";
	}

	private String generateTimesheetInvoiceForExpense(Invoice invoice,
			ModelMap modelMap, BindingResult result, HttpServletRequest request) {
		Long timesheetId = invoice.getTimesheet().getId();

		String invoicePrefixId = DateUtils.getMonthAndYearString(invoice.getInvoiceDate());
		String invoiceId = invoicePrefixId + "-" + invoice.getSerialNumber();
		invoice.setInvoiceId(invoiceId);
		String invoiceDate = DateUtils.formatDate(invoice.getInvoiceDate(), getMessage(Constants.DATE_PATTERN_KEY));

		// Persist Invoice entity
		invoice = invoiceService.saveOrUpdate(invoice);
		Timesheet timesheet = timesheetService.load(timesheetId);

		List<Invoice> invoices = new ArrayList<Invoice>();
		invoices.add(invoice);
		JRBeanCollectionDataSource jrDataSource = new JRBeanCollectionDataSource(invoices, false);

		Float travelTotalDistance = timesheet.getTotalTravelDistance().floatValue();
		Float timesheetTotalExpense = timesheet.getTotalExpense().floatValue();
		Float ratioPerKilometer = constantsService
				.findFloatValueByKey(ConstantsService.CONST_KEY_EXPENSE_GAS_SUBSIDY_PER_KILOMETER);

		modelMap.put("invoiceDate", invoiceDate);
		modelMap.put("onkosten", 0.0);
		modelMap.put("travelTotalDistance", travelTotalDistance);
		modelMap.put("ratioPerKilometer", ratioPerKilometer);
		modelMap.put("timesheetTotalExpense", MathUtils.roundToTwoDecimalPlaces(timesheetTotalExpense));
		modelMap.put("timesheetInvoiceExpenseList", jrDataSource);
		modelMap.put("format", "pdf");
		modelMap.put(Constants.IMAGE_HM_LOGO, getFileFullPath(request, Constants.imageHMlogoAddress));
		modelMap.put("reportFileName", "FAK-" + invoiceId);

		// Calacuate subtotal
		Double subTotal = timesheetService.calculateTotalExpenseAmountPayable(timesheet);
		modelMap.put("subTotal", MathUtils.roundToTwoDecimalPlaces(subTotal));

		Double timesheetTravelTax = timesheetService.calculateVatTax(travelTotalDistance.doubleValue()
				* ratioPerKilometer);
		modelMap.put("timesheetTravelTax", MathUtils.roundToTwoDecimalPlaces(timesheetTravelTax));

		Double totalAmount = subTotal + timesheetTravelTax;
		modelMap.put("totalAmount", MathUtils.roundToTwoDecimalPlaces(totalAmount));

		return "timesheetInvoiceExpenseList";
	}

	public String getFileFullPath(HttpServletRequest request, String filePath) {
		String appServerHome = request.getSession().getServletContext().getRealPath("/");
		return appServerHome + filePath;
	}

	// This method exist only for solve Javascript relative path issue
	@RequestMapping(value = "/admin/admin/timesheet/delete/{id}")
	public String deleteTimesheet2(@PathVariable("id") Long id) {
		return deleteTimesheet(id);
	}

	// This method exist only for solve Javascript relative path issue
	@RequestMapping(value = "/admin/admin/timesheet/archive/{id}")
	public String archiveTimesheet2(@PathVariable("id") Long id) {
		return archiveTimesheet(id);
	}
}