/*
 * Created on Feb 26, 2010 - 3:21:43 PM
 */
package nl.hajari.wha.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import nl.hajari.wha.service.OptionsProvider;
import nl.hajari.wha.service.TimesheetService;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
@Service
public class TimesheetPossibleYearsOptionsProvider implements OptionsProvider<Integer, String> {

	public static final String TIMESHEET_POSSIBLE_YEARS_KEY = "timesheetPossibleYears";

	protected final Log logger = LogFactory.getLog(getClass());

	protected Map<Integer, String> possibleYears;

	@Autowired
	protected TimesheetService timesheetService;

	@Override
	public Map<Integer, String> getOptions() {
		if (null == possibleYears) {
			possibleYears = new HashMap<Integer, String>();
		}
		fillOptions(possibleYears);
		logger.debug(possibleYears);
		return possibleYears;
	}

	@Override
	public void fillOptions(Map<Integer, String> options) {
		if (!options.isEmpty()) {
			return;
		}
		List<Integer> years = timesheetService.findAllTimesheetYears();
		for (Integer y : years) {
			options.put(y, y.toString());
		}
	}

	public void setTimesheetService(TimesheetService timesheetService) {
		this.timesheetService = timesheetService;
	}

}
