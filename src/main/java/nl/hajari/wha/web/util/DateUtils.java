package nl.hajari.wha.web.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

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

	public static String getMonthAndYearString(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("MMyy");
		return format.format(date);
	}

	public static String formatDate(Date date, String pattern) {
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		return format.format(date);
	}

	private static Locale getCurrentLocale() {
		return LocaleUtils.getCurrentLocale();
	}

}
