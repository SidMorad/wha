/*
 * Created on Dec 12, 2009 - 2:57:36 AM
 */
package nl.hajari.wha.service.json;

import java.io.IOException;

import nl.hajari.wha.domain.Project;

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
public class ProjectSerializer extends JsonSerializer<Project> {

	protected final Log logger = LogFactory.getLog(getClass());

	@Override
	public void serialize(Project value, JsonGenerator jgen, SerializerProvider provider) throws IOException,
			JsonProcessingException {

		jgen.writeStartObject();

		jgen.writeFieldName("id");
		jgen.writeNumber(value.getId());

		jgen.writeFieldName("name");
		jgen.writeString(value.toString());

		jgen.writeEndObject();

		logger.debug("Project [" + value + "] mapped to JSON.");
	}

}