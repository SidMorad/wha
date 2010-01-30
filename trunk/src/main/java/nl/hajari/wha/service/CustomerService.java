/*
 * Created on Jan 30, 2010 - 6:02:18 PM
 */
package nl.hajari.wha.service;

import java.util.List;

import nl.hajari.wha.domain.Customer;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public interface CustomerService {

	/**
	 * @return
	 */
	List<Customer> findAll();

	/**
	 * @param name
	 */
	void setExpenseDefaultCustomerName(String name);

	/**
	 * @return
	 */
	Customer findExpenseDefaultCustomer();

}
