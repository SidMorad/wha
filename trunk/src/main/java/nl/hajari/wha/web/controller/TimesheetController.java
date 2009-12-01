package nl.hajari.wha.web.controller;

import java.util.Calendar;
import java.util.Date;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.domain.User;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RooWebScaffold(path = "timesheet", automaticallyMaintainView = false, formBackingObject = Timesheet.class, update = false, delete = false)
@RequestMapping("/timesheet/**")
@Controller
public class TimesheetController {

	public Timesheet getTimesheetByDayDateAndCurrentEmployee(Date dayDate) {
		User currentUser = (User) User.findUsersByUsernameEquals(SecurityContextHolder.getContext().getAuthentication().getName()).getSingleResult(); 
		Employee currentEmployee = (Employee) Employee.findEmployeesByUser(currentUser).getSingleResult();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dayDate);
		int sheetYear = calendar.get(Calendar.YEAR);
		int sheetMonth = calendar.get(Calendar.MONTH);
		Timesheet timesheet = new Timesheet();
		try {
			timesheet = (Timesheet) Timesheet.findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals(currentEmployee, sheetMonth, sheetYear).getSingleResult();
		} catch (Exception e) {
			// if timesheet doesn't exist make one. 
			timesheet.setSheetYear(sheetYear);
			timesheet.setSheetMonth(sheetMonth);
			timesheet.setEmployee(currentEmployee);
			timesheet.setMonthlyTotal(0f);
			timesheet.persist();
		}
		return timesheet;
	}	
}
