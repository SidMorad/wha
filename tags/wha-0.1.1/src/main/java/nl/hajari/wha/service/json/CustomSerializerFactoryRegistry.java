/*
 * Created on Dec 12, 2009 - 3:13:45 AM
 */
package nl.hajari.wha.service.json;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.ser.CustomSerializerFactory;
import org.springframework.beans.factory.InitializingBean;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot nl]
 */
public class CustomSerializerFactoryRegistry extends CustomSerializerFactory implements InitializingBean {

	protected final Log logger = LogFactory.getLog(getClass());

	private Map<Class, JsonSerializer> serializers = new HashMap<Class, JsonSerializer>();

	@Override
	public <T> JsonSerializer<T> createSerializer(Class<T> type, SerializationConfig config) {
		JsonSerializer<T> serializer = super.createSerializer(type, config);
		logger.debug("Found serializer [" + serializer + "] for type [" + type + "].");
		return serializer;
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		for (Map.Entry<Class, JsonSerializer> e : serializers.entrySet()) {
			addGenericMapping(e.getKey(), e.getValue());
		}
		logger.info("Registered all serializers: " + serializers);
	}

	public void setSerializers(Map<Class, JsonSerializer> serializers) {
		this.serializers = serializers;
	}

}
