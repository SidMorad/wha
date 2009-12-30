package nl.hajari.wha.web.controller.formbean;

import javax.validation.constraints.NotNull;

import nl.hajari.wha.domain.Customer;

/**
 * This class represents formBackingBean for handle dailyTimesheet report
 * action.
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 **/
public class TimesheetDailyReportFormBean {

	@NotNull
	private Long timesheetId;

	@NotNull
	private Customer customer;

	@NotNull
	private String format;

	public Long getTimesheetId() {
		return timesheetId;
	}

	public void setTimesheetId(Long timesheetId) {
		this.timesheetId = timesheetId;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public String getFormat() {
		return format;
	}

	public void setFormat(String format) {
		this.format = format;
	}
}
