/*
 * Created on Jan 30, 2010 - 6:11:33 PM
 */
package nl.hajari.wha.service.impl;

import nl.hajari.wha.service.LogService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public class AbstractService {

	protected final Log logger = LogFactory.getLog(getClass());

	// @Autowired
	protected LogService logService;

	public void setLogService(LogService logService) {
		this.logService = logService;
	}

}
