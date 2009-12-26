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
@Constraint(validatedBy = ProjectCreationInDailyTimesheetValidator.class)
public @interface ProjectCreationInDailyTimesheet {

	String message() default "{error.project.binding.fail}";

	Class<?>[] groups() default {};

	Class<? extends Payload>[] payload() default {};

}
