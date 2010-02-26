/*
 * Created on Feb 26, 2010 - 2:52:16 PM
 */
package nl.hajari.wha.service.impl;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import nl.hajari.wha.service.OptionsProvider;
import nl.hajari.wha.web.util.DateUtils;
import nl.hajari.wha.web.util.LocaleUtils;

import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 */
@Service
public class LocaleAwareCalendarOptionsProvider implements OptionsProvider<Integer, String> {

	public static String POSSIBLE_TIMESHEET_MONTHS_KEY = "possibleTimesheetMonthts";

	protected final Log logger = LogFactory.getLog(getClass());

	protected Map<Locale, Map<Integer, String>> possibleTimesheetMonths = null;

	@Override
	public Map<Integer, String> getOptions() {
		if (null == possibleTimesheetMonths) {
			possibleTimesheetMonths = new ListOrderedMap();
		}
		Locale locale = LocaleUtils.getCurrentLocale();
		if (!possibleTimesheetMonths.containsKey(locale)) {
			possibleTimesheetMonths.put(locale, new HashMap<Integer, String>());
			fillOptions(possibleTimesheetMonths.get(locale));
		}
		logger.debug(possibleTimesheetMonths);
		return possibleTimesheetMonths.get(LocaleUtils.getCurrentLocale());
	}

	@Override
	public void fillOptions(Map<Integer, String> options) {
		if (!options.isEmpty()) {
			return;
		}
		// TODO it would be better if can interrelate two options together :D
		Integer curMon = DateUtils.getCurrentMonth();
		for (int i = 0; i <= 11; ++i) {
			String monName = DateUtils.getSheetMonthShortName(i);
			options.put(i, monName);
		}
	}

}
