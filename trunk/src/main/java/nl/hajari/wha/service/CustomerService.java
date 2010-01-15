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
	private static final String DEFAULT_EXPENSE_CUSTOMER_NAME = "Hajari Multitasking";

	private String defaultExpenseCustomerName = DEFAULT_EXPENSE_CUSTOMER_NAME;

	public List<Customer> findAll() {
		List<Customer> list = Customer.findAllCustomers();
		logger.debug("All customers fetched with size: [" + list.size() + "]");
		return list;
	}

	public Customer findExpenseDefaultCustomer() {
		try {
			Customer customer = (Customer) Customer.findCustomersByNameEquals(defaultExpenseCustomerName)
					.getSingleResult();
			logger.debug("Found the default expense customer with name [" + defaultExpenseCustomerName + "]");
			return customer;
		} catch (Exception e) {
			logger.error("Failed to find the default customer for expense with name [" + defaultExpenseCustomerName
					+ "]. Reason: " + e.getMessage());
		}
		return null;
	}

	public void setDefaultExpenseCustomerName(String defaultExpenseCustomerName) {
		this.defaultExpenseCustomerName = defaultExpenseCustomerName;
	}
}