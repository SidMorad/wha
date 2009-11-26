package nl.hajari.wha.web.util;

import java.util.Calendar;
import java.util.Locale;

import nl.hajari.wha.domain.enums.Month;

public class DateUtils {

	public static Integer getCurrentYear() {
		return Calendar.getInstance().get(Calendar.YEAR);
	}

	public static String getCurrentMonthShortName() {
		return Calendar.getInstance().getDisplayName(Calendar.MONTH, Calendar.SHORT, Locale.getDefault());
	}

	public static Integer getCurrentMonth() {
		return Calendar.getInstance().get(Calendar.MONTH);
	}

	public static Month getCurrentMonthEnum() {
		return Month.class.getEnumConstants()[Calendar.getInstance().get(Calendar.MONTH)];
	}

}
