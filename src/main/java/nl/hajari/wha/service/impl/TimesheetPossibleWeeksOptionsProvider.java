/*
 * Created on 23/04/2010 - 11:11:58 PM 
 */
package nl.hajari.wha.service.impl;

import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import nl.hajari.wha.service.OptionsProvider;
import nl.hajari.wha.web.controller.formbean.Week;
import nl.hajari.wha.web.util.DateUtils;
import nl.hajari.wha.web.util.LocaleUtils;

import org.apache.commons.collections.map.ListOrderedMap;
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

	private String datePattern;

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
		Map<Integer, Week> weeks = DateUtils.getCurrentMonthWeeks();
		for (Integer i : weeks.keySet()) {
			Week week = weeks.get(i);
			options.put(i, DateUtils.formatDate(week.getStartDate(), this.datePattern) + " - "
					+ DateUtils.formatDate(week.getEndDate(), this.datePattern));
		}
	}

	public Map<Integer, String> buildWeeks(String datePattern) {
		if (null == possibleWeeks) {
			possibleWeeks = new ListOrderedMap();
		}
		this.datePattern = datePattern;
		fillOptions(possibleWeeks);
		return possibleWeeks;
	}

	public Map<String, String> buildWeekLabels(Week week, String datePattern) {
		Map<String, String> labels = new ListOrderedMap();
		if (null == week) {
			return labels;
		}
		Calendar c = Calendar.getInstance(LocaleUtils.getCurrentLocale());
		c.setTime(week.getStartDate());
		int day = c.get(Calendar.DAY_OF_WEEK);
		if (day != Calendar.SUNDAY) {
			for (int i = 1; i < day; ++i) {
				labels.put("day" + i, "---");
			}
		}
		for (int i = day; i <= 7; ++i) {
			if (c.getTime().getTime() <= week.getEndDate().getTime()) {
				labels.put("day" + i, DateUtils.formatDate(c.getTime(), datePattern));
			} else {
				labels.put("day" + i, "---");
			}
			c.add(Calendar.DAY_OF_MONTH, 1);
		}
		logger.warn("Week [" + week + "] labels: " + labels);
		return labels;
	}

}
