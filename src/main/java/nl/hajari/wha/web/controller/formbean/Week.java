/*
 * Created on Apr 24, 2010 - 3:43:30 PM
 */
package nl.hajari.wha.web.controller.formbean;

import java.util.Date;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public class Week {

	private Date startDate;
	private Date endDate;

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "(" + startDate + ", " + endDate + ")";
	}

}
