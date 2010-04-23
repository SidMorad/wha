package nl.hajari.wha.web.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

import nl.hajari.wha.domain.Timesheet;

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

	public static Date getFirstDateOfRelatedYearAndMonth(Timesheet timesheet) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(timesheet.getSheetYear(), timesheet.getSheetMonth(), 1);
		return calendar.getTime();
	}

	public static String getWeek(int i) {
		//TODO::return correct values!
		Calendar calendar = Calendar.getInstance();
		int currentMonth = calendar.get(Calendar.MONTH);
		if (i == 1) {
			return " 1-"+currentMonth +" - "+ " 7-"+currentMonth;
		}
		else if (i == 2) {
			return " 8-"+currentMonth +" - "+ "15-"+currentMonth;
		}
		else if (i == 3) {
			return "16-"+currentMonth +" - "+ "23-"+currentMonth;
		}
		else if (i == 4) {
			return "24-"+currentMonth +" - "+ "30-"+currentMonth;
		}
		return null;
	}
	
}
