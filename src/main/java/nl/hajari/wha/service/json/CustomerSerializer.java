/*
 * Created on Dec 16, 2009 - 6:21:48 PM
 */
package nl.hajari.wha.service.json;

import java.io.IOException;

import nl.hajari.wha.domain.Customer;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.JsonSerializer;
import org.codehaus.jackson.map.SerializerProvider;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot nl]
 */
public class CustomerSerializer extends JsonSerializer<Customer> {

	protected final Log logger = LogFactory.getLog(getClass());

	@Override
	public void serialize(Customer value, JsonGenerator jgen, SerializerProvider provider) throws IOException,
			JsonProcessingException {
		jgen.writeStartObject();
		jgen.writeFieldName("id");
		jgen.writeNumber(value.getId());
		jgen.writeFieldName("name");
		jgen.writeString(value.toString());
		jgen.writeEndObject();
		logger.debug("Customer [" + value + "] mapped to JSON");
	}

}
