package nl.hajari.wha.web.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import nl.hajari.wha.Constants;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.web.controller.formbean.Week;

import org.apache.commons.collections.map.ListOrderedMap;

public class DateUtils {

	public static Integer getCurrentYear() {
		return Calendar.getInstance().get(Calendar.YEAR);
	}

	public static String getCurrentMonthShortName() {
		return Calendar.getInstance().getDisplayName(Calendar.MONTH, Calendar.SHORT, getCurrentLocale());
	}

	public static Integer getCurrentMonth() {
		return Calendar.getInstance().get(Calendar.MONTH);
	}

	public static String getSheetMonthShortName(Integer month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.MONTH, month);
		return calendar.getDisplayName(Calendar.MONTH, Calendar.SHORT, getCurrentLocale());
	}

	public static String getSheetMonthLongName(Integer month) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.MONTH, month);
		return calendar.getDisplayName(Calendar.MONTH, Calendar.LONG, getCurrentLocale());
	}

	public static Integer getMonthInteger(Date dayDate) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dayDate);
		return calendar.get(Calendar.MONTH);
	}

	public static Integer getYearInteger(Date dayDate) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dayDate);
		return calendar.get(Calendar.YEAR);
	}
	
	public static Integer getDayInteger(Date dayDate) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dayDate);
		return calendar.get(Calendar.DAY_OF_MONTH);
	}
	
	public static Date getDateObject(String dateString, String pattern) {
		DateFormat df = new SimpleDateFormat(pattern);
		try {
			Date date = df.parse(dateString);
			return date;
		} catch(ParseException e) {
			e.printStackTrace();
			return null;
		}
	}
	

	public static String getMonthAndYearString(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("MMyy");
		return format.format(date);
	}

	public static String formatDate(Date date, String pattern) {
		SimpleDateFormat format = new SimpleDateFormat(pattern, getCurrentLocale());
		return format.format(date);
	}

	private static Locale getCurrentLocale() {
		return LocaleUtils.getCurrentLocale();
	}

	public static Date getFirstDateOfRelatedYearAndMonth(Timesheet timesheet) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(timesheet.getSheetYear(), timesheet.getSheetMonth(), 1);
		return calendar.getTime();
	}

	public static Map<Integer, Week> getCurrentMonthWeeks() {
		Map<Integer, Week> weeks = new ListOrderedMap();

		Calendar c = Calendar.getInstance(getCurrentLocale());
		c.setFirstDayOfWeek(Constants.WEEK_FIRST_DAY);
		c.setTime(new Date());
		c.set(Calendar.DAY_OF_MONTH, 1);
		
		int delta = Constants.WEEK_FIRST_DAY - Calendar.SUNDAY;
		int relativeWeekDays = 7 - Constants.WEEK_FIRST_DAY;

		Week week1 = new Week();
		week1.setStartDate(c.getTime());
		if (c.get(Calendar.DAY_OF_WEEK) == Constants.WEEK_FIRST_DAY) {
			c.add(Calendar.DAY_OF_MONTH, relativeWeekDays);
			week1.setEndDate(c.getTime());
		} else {
			c.add(Calendar.DAY_OF_MONTH, ((7 + delta) - c.get(Calendar.DAY_OF_WEEK)));
			week1.setEndDate(c.getTime());
		}
		weeks.put(1, week1);

		Week week2 = new Week();
		c.add(Calendar.DAY_OF_MONTH, 1);
		week2.setStartDate(c.getTime());
		c.add(Calendar.DAY_OF_MONTH, 6);
		week2.setEndDate(c.getTime());
		weeks.put(2, week2);

		Week week3 = new Week();
		c.add(Calendar.DAY_OF_MONTH, 1);
		week3.setStartDate(c.getTime());
		c.add(Calendar.DAY_OF_MONTH, 6);
		week3.setEndDate(c.getTime());
		weeks.put(3, week3);

		int maxMonthDays = c.getActualMaximum(Calendar.DAY_OF_MONTH);
		Week week4 = new Week();
		c.add(Calendar.DAY_OF_MONTH, 1);
		week4.setStartDate(c.getTime());
		int dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
		if (dayOfMonth + 6 <= maxMonthDays) {
			c.add(Calendar.DAY_OF_MONTH, 6);
			week4.setEndDate(c.getTime());
		} else {
			c.add(Calendar.DAY_OF_MONTH, maxMonthDays - dayOfMonth + 1);
			week4.setEndDate(c.getTime());
		}
		weeks.put(4, week4);

		dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
		if (dayOfMonth < maxMonthDays) {
			Week week5 = new Week();
			c.add(Calendar.DAY_OF_MONTH, 1);
			week5.setStartDate(c.getTime());
			dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
			if (dayOfMonth + 6 <= maxMonthDays) {
				c.add(Calendar.DAY_OF_MONTH, 6);
				week5.setEndDate(c.getTime());
			} else {
				c.add(Calendar.DAY_OF_MONTH, maxMonthDays - dayOfMonth);
				week5.setEndDate(c.getTime());
			}
			weeks.put(5, week5);
		}

		dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
		if (dayOfMonth < maxMonthDays) {
			Week week6 = new Week();
			c.add(Calendar.DAY_OF_MONTH, 1);
			week6.setStartDate(c.getTime());
			dayOfMonth = c.get(Calendar.DAY_OF_MONTH);
			if (dayOfMonth + 6 <= maxMonthDays) {
				c.add(Calendar.DAY_OF_MONTH, 6);
				week6.setEndDate(c.getTime());
			} else {
				c.add(Calendar.DAY_OF_MONTH, maxMonthDays - dayOfMonth);
				week6.setEndDate(c.getTime());
			}
			weeks.put(6, week6);
		}
		
		return weeks;
	}

}
