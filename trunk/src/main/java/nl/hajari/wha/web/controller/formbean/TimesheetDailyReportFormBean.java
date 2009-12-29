package nl.hajari.wha.web.controller.formbean;

import nl.hajari.wha.domain.Customer;

/**
 * This class represents formBackingBean for handle dailyTimesheet report
 * action.
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 **/
public class TimesheetDailyReportFormBean {

	private Long timesheetId;
	
	private Customer customer;

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
}
