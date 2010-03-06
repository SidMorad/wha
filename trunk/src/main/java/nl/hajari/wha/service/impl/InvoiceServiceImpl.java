/*
 * Created on 06/03/2010 - 6:40:49 PM 
 */
package nl.hajari.wha.service.impl;

import nl.hajari.wha.domain.Invoice;
import nl.hajari.wha.service.InvoiceService;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

/**
 *
 *
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>	
 */
@Service
public class InvoiceServiceImpl extends AbstractService implements InvoiceService{

	@Override
	public void saveOrUpdate(Invoice invoice) {
		Invoice checkInvoice = null;
		try {
			// We check if any Invoice exist for selected timesheet
			checkInvoice = (Invoice) Invoice.findInvoicesByTimesheet(invoice.getTimesheet()).getSingleResult();

			// If Invoice founded , set id and version then merge the entity
			invoice.setId(checkInvoice.getId());
			invoice.setVersion(checkInvoice.getVersion());
			invoice.merge();
			logService.log(null, null, null, invoice.getTimesheet(), "Invoice Updated");
		} catch (DataAccessException e) {
			invoice.persist();
			logService.log(null, null, null, invoice.getTimesheet(), "Invoice Created");
		}
	}

}
