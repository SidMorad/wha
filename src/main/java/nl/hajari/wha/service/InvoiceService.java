/*
 * Created on 06/03/2010 - 6:38:22 PM 
 */
package nl.hajari.wha.service;

import nl.hajari.wha.domain.Invoice;

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
	void saveOrUpdate(Invoice invoice);
}
