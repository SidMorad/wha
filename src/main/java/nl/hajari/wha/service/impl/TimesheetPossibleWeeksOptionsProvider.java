/*
 * Created on 23/04/2010 - 11:11:58 PM 
 */
package nl.hajari.wha.service.impl;

import java.util.HashMap;
import java.util.Map;

import nl.hajari.wha.service.OptionsProvider;
import nl.hajari.wha.web.util.DateUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 *
 *
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>	
 */
@Service
public class TimesheetPossibleWeeksOptionsProvider implements OptionsProvider<Integer, String> {

	public static final String TIMESHEET_POSSIBLE_WEEKS_KEY = "timesheetPossibleWeeks";
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	protected Map<Integer, String> possibleWeeks;
	
	@Override
	public Map<Integer, String> getOptions() {
		if (null == possibleWeeks) {
			possibleWeeks = new HashMap<Integer, String>();
		}
		fillOptions(possibleWeeks);
		logger.debug(possibleWeeks);
		return possibleWeeks;
	}

	@Override
	public void fillOptions(Map<Integer, String> options) {
		if (!options.isEmpty()) {
			return;
		}
		possibleWeeks.put(1, DateUtils.getWeek(1));
		possibleWeeks.put(2, DateUtils.getWeek(2));
		possibleWeeks.put(3, DateUtils.getWeek(3));
		possibleWeeks.put(4, DateUtils.getWeek(4));
		
	}
	
}
