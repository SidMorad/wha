package nl.hajari.wha.web.validator;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Project;

import org.springframework.util.StringUtils;

public class ProjectCreationInDailyTimesheetValidator implements
		ConstraintValidator<ProjectCreationInDailyTimesheet, DailyTimesheet> {

	@Override
	public void initialize(ProjectCreationInDailyTimesheet constraintAnnotation) {
	}

	@Override
	public boolean isValid(DailyTimesheet dailyTimesheet, ConstraintValidatorContext context) {
		if (StringUtils.hasText(dailyTimesheet.getProjectName())) {
			return true;
		}
		Project sp = dailyTimesheet.getProject();
		if (sp == null) {
			if (!StringUtils.hasText(dailyTimesheet.getProjectName())) {
				return false;
			}
		} else {
			if (StringUtils.hasText(dailyTimesheet.getProjectName())) {
				return false;
			}
		}

		return true;
	}

}
