/*
 * Created on Feb 26, 2010 - 2:50:06 PM
 */
package nl.hajari.wha.service;

import java.util.Map;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public interface OptionsProvider<K, V> {

	/**
	 * @return
	 */
	Map<K, V> getOptions();

	/**
	 * @param options
	 */
	void fillOptions(Map<K, V> options);

}
