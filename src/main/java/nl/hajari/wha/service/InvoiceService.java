/*
 * Created on 06/03/2010 - 6:38:22 PM 
 */
package nl.hajari.wha.service;

import nl.hajari.wha.domain.Invoice;
import nl.hajari.wha.domain.InvoiceType;
import nl.hajari.wha.domain.Timesheet;

/**
 * 
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
public interface InvoiceService {

	/**
	 * 
	 * @param invoice
	 */
	Invoice saveOrUpdate(Invoice invoice);

	/**
	 * @param timesheet
	 * @return
	 */
	Invoice loadByTimesheet(Timesheet timesheet);

	/**
	 * 
	 * @param timesheet
	 * @return true if succeed
	 */
	boolean deleteInvoiceByTimesheet(Timesheet timesheet);

	/**
	 * 
	 * @param timesheet
	 * @param invoiceType
	 * @return invoice
	 */
	Invoice findByTimesheetAndInvoiceType(Timesheet timesheet, InvoiceType invoiceType);

}
