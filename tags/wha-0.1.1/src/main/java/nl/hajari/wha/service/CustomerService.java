/*
 * Created on Dec 16, 2009 - 6:27:30 PM
 */
package nl.hajari.wha.service;

import java.util.List;

import nl.hajari.wha.domain.Customer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot nl]
 */
@Service
public class CustomerService {

	protected final Log logger = LogFactory.getLog(getClass());

	public List<Customer> findAll() {
		List<Customer> list = Customer.findAllCustomers();
		logger.debug("All customers fetched with size: [" + list.size() + "]");
		return list;
	}

}
