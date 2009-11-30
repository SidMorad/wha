package nl.hajari.wha.domain;

import javax.persistence.Query;

import nl.hajari.wha.web.util.DateUtils;

import org.springframework.transaction.annotation.Transactional;

privileged aspect Timesheet_Wha_Entity {

	@Transactional
	public static int Timesheet.updateTimesheetTotalMonthly(Long id, Float total) {
		Timesheet timesheet = Timesheet.findTimesheet(id);
		timesheet.setMonthlyTotal(total);
		timesheet.merge();
		timesheet.flush();
		return 0;
	}
	
	public static Query Timesheet.findEmployeeCurrentTimesheet(Long employeeId) {
		Employee employee = Employee.findEmployee(employeeId);
		Query query = Timesheet.findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals(employee, DateUtils
				.getCurrentMonth(), DateUtils.getCurrentYear());
		return query;
	}

	
}
