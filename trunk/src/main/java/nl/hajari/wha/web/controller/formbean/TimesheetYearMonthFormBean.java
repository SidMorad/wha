package nl.hajari.wha.web.controller.formbean;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
public class TimesheetYearMonthFormBean {

	@NotNull
	@Min(value = 2009)
	@Size(min = 4, max = 4)
	private Integer year;

	@NotNull
	@Min(value = 1)
	@Max(value = 12)
	@Size(min = 1, max = 2)
	private Integer month;

	public TimesheetYearMonthFormBean() {
	}
	
	public TimesheetYearMonthFormBean(Integer year, Integer month) {
		this.year = year;
		this.month = month;
	}
	
	public Integer getYear() {
		return year;
	}
	
	public void setYear(Integer year) {
		this.year = year;
	}
	
	public Integer getMonth() {
		return month;
	}
	
	public void setMonth(Integer month) {
		this.month = month;
	}
	
}
