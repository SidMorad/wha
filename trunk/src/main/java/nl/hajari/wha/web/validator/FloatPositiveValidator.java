package nl.hajari.wha.web.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

/**
 * This class is used by FloatPositive interface.
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
public class FloatPositiveValidator implements ConstraintValidator<FloatPositive, Float> {

	@Override
	public void initialize(FloatPositive constraintAnnotation) {
	}

	@Override
	public boolean isValid(Float value, ConstraintValidatorContext context) {
		if (value == null) {
			return true;
		}
		if (value > 0 ) {
			return true;
		}
		return false;
	}

}
