/*
 * Created on Jan 30, 2010 - 6:11:33 PM
 */
package nl.hajari.wha.service.impl;

import java.util.Properties;

import javax.annotation.Resource;

import nl.hajari.wha.service.LogService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.NoSuchMessageException;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
public class AbstractService {

	protected final Log logger = LogFactory.getLog(getClass());

	@Resource
	@Qualifier("configs")
	private Properties configs;

	// @Autowired
	protected LogService logService;

	public void setLogService(LogService logService) {
		this.logService = logService;
	}

	protected String getConfig(String key) {
		String value = null;
		try {
			value = configs.getProperty(key);
			logger.debug("Config resolved [" + key + "=" + value + "]");
		} catch (NoSuchMessageException e) {
			logger.error("No config found with key: " + key);
		}
		return value;
	}

}
