package nl.hajari.wha.web.validator;

import java.util.Calendar;
import java.util.Date;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import nl.hajari.wha.domain.DailyTimesheet;

public class DayDateIsInCurrentMonthValidator implements ConstraintValidator<DayDateIsInCurrentMonth, DailyTimesheet>{

	@Override
	public void initialize(DayDateIsInCurrentMonth constraintAnnotation) {
		// do nothing ...
	}

	@Override
	public boolean isValid(DailyTimesheet dailyTimesheet, ConstraintValidatorContext constraintValidatorContext) {
		if (dailyTimesheet.getDayDate() == null) {
			return true;
		}
		Calendar cal1 = Calendar.getInstance();
		cal1.setTime(new Date());
		Calendar cal2 = Calendar.getInstance();
		cal2.setTime(dailyTimesheet.getDayDate());
		
		if (cal1.get(Calendar.YEAR) != cal2.get(Calendar.YEAR) || cal1.get(Calendar.MONTH) != cal2.get(Calendar.MONTH)) {
			return false;
		}
		return true;
	}

}
