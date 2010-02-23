/*
 * Created on Feb 23, 2010 - 1:34:35 PM
 */
package nl.hajari.wha.service;

import java.util.List;
import java.util.Map;

import nl.hajari.wha.domain.Constants;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public interface ConstantsService {

	/*
	 * Constants
	 */
	String CONST_KEY_EXPENSE_VAT = "expense_vat";
	String CONST_KEY_EXPENSE_GAS_SUBSIDY_PER_KILOMETER = "expense_gas_subsidy_per_kilometer";
	String CONST_KEY_SALARY_BONUS_RATIO_PER_HOUR = "salary_bonus_ratio_per_hour";
	String CONST_KEY_SALARY_TAX_RATIO = "salary_tax_ratio";

	/**
	 * @param constants
	 */
	void save(Constants constants);

	/**
	 * @param key
	 * @param value
	 */
	void save(String key, String value);

	/**
	 * @param constants
	 */
	void update(Constants constants);

	/**
	 * @return
	 */
	List<Constants> loadAll();

	/**
	 * @param id
	 * @return
	 */
	Constants load(Long id);

	/**
	 * @param id
	 */
	void delete(Long id);

	/**
	 * @param key
	 * @return
	 */
	boolean exists(String key);

	/**
	 * @param key
	 * @return
	 */
	String findValue(String key);

	/**
	 * @param key
	 * @return
	 */
	Constants findByKey(String key);

	/**
	 * @return
	 */
	Map<String, String> getDefaultValues();

}
