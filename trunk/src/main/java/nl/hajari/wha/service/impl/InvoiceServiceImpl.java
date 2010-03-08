/*
 * Created on 06/03/2010 - 6:40:49 PM 
 */
package nl.hajari.wha.service.impl;

import nl.hajari.wha.domain.Invoice;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.InvoiceService;

import org.springframework.stereotype.Service;

/**
 * 
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
@Service
public class InvoiceServiceImpl extends AbstractService implements InvoiceService {

	@Override
	public Invoice loadByTimesheet(Timesheet timesheet) {
		try {
			Invoice invoice = (Invoice) Invoice.findInvoicesByTimesheet(timesheet).getSingleResult();
			return invoice;
		} catch (Exception e) {
		}
		return null;
	}

	@Override
	public Invoice saveOrUpdate(Invoice invoice) {
		Timesheet timesheet = invoice.getTimesheet();
		// We check if any Invoice exist for selected timesheet
		Invoice currInvoice = loadByTimesheet(timesheet);
		if (null != currInvoice) {
			// If Invoice found, set id and version then merge the entity
			currInvoice.setId(invoice.getId());
			currInvoice.setInvoiceDate(invoice.getInvoiceDate());
			currInvoice.setSerialNumber(invoice.getSerialNumber());
			currInvoice.setInvoiceId(invoice.getInvoiceId());
			currInvoice.merge();
			logService.log(null, null, null, invoice.getTimesheet(), "Invoice Updated");
			return currInvoice;
		} else {
			invoice.persist();
			logService.log(null, null, null, invoice.getTimesheet(), "Invoice Created");
			return invoice;
		}
	}

}
