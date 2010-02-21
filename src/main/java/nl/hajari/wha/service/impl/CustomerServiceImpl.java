/*
 * Created on Dec 16, 2009 - 6:27:30 PM
 */
package nl.hajari.wha.service.impl;

import java.util.List;

import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.service.CustomerService;

import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot nl]
 */
@Service
public class CustomerServiceImpl extends AbstractService implements CustomerService, InitializingBean {

	private static final String DEFAULT_EXPENSE_CUSTOMER_NAME = "HM Solutions";

	private String DEFAULT_EXPENSE_CUSTOMER_NAME_KEY = "default.expense.customer.name";
	private String defaultExpenseCustomerName;

	@Override
	public void afterPropertiesSet() throws Exception {
		if (null == defaultExpenseCustomerName) {
			String value = getConfig(DEFAULT_EXPENSE_CUSTOMER_NAME_KEY);
			defaultExpenseCustomerName = (null == value) ? DEFAULT_EXPENSE_CUSTOMER_NAME : value;
		}
		logger.debug("Using [" + defaultExpenseCustomerName + "] as the default customer name for expenses.");
	}

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

	public void setExpenseDefaultCustomerName(String defaultExpenseCustomerName) {
		this.defaultExpenseCustomerName = defaultExpenseCustomerName;
	}
}
