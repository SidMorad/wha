/*
 * Created on Dec 12, 2009 - 3:34:33 AM
 */
package nl.hajari.wha.service.json;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializerFactory;

/**
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot nl]
 */
public class CustomObjectMapper extends ObjectMapper {

	protected final Log logger = LogFactory.getLog(getClass());

	/**
	 * We had to extend this because in the super
	 * {@link ObjectMapper#setSerializerFactory(SerializerFactory)} is not a
	 * 'void' method which is required for Spring injection.
	 * 
	 * @param factory
	 */
	public void setCustomSerializerFactory(SerializerFactory factory) {
		setSerializerFactory(factory);
		logger.debug("Using [" + factory + "] as the custom Jackson JSON serializer factory.");
	}

}
