package nl.hajari.wha.web.validator;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Documented
@Constraint(validatedBy = DayDateIsInCurrentMonthValidator.class)
public @interface DayDateIsInCurrentMonth {

	String message() default "error.time.day.date.not.avaiable";

	Class<?>[] groups() default {};

	Class<? extends Payload>[] payload() default {};

}
