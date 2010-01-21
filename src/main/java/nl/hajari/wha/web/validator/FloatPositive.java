package nl.hajari.wha.web.validator;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

/**
 * The annotated element must be a number whose value must be positive.
 * <p/>
 * Supported types are:
 * <ul>
 * <li><code>Float</code></li>
 * </ul>
 * <code>null</code> elements are considered valid
 *
  * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>	
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
@Constraint(validatedBy = FloatPositiveValidator.class)
public @interface FloatPositive {
	String message() default "{field.invalid.float.positive}";

	Class<?>[] groups() default {};

	Class<? extends Payload>[] payload() default {};

}
