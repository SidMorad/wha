package nl.hajari.wha.web.controller;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.domain.User;
import nl.hajari.wha.web.util.DateUtils;
import nl.hajari.wha.web.util.SecurityContextUtils;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RooWebScaffold(path = "timesheet", automaticallyMaintainView = false, formBackingObject = Timesheet.class, update = false, delete = false)
@RequestMapping("/timesheet/**")
@Controller
public class TimesheetController {

	protected final Log logger = LogFactory.getLog(getClass());
	
	public Timesheet getTimesheetOrCreateOneForCurrentEmployee() {
		User currentUser = (User) User.findUsersByUsernameEquals(SecurityContextUtils.getCurrentUsername()).getSingleResult(); 
		Employee currentEmployee = (Employee) Employee.findEmployeesByUser(currentUser).getSingleResult();
		int sheetYear = DateUtils.getCurrentYear();
		int sheetMonth = DateUtils.getCurrentMonth();
		Timesheet timesheet = new Timesheet();
		try {
			timesheet = (Timesheet) Timesheet.findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals(currentEmployee, sheetMonth, sheetYear).getSingleResult();
		} catch (DataAccessException dae) {
			logger.debug("Looks like there is no timesheet for this employee[" + currentEmployee + "] , " +
					"let's create one in [" + sheetYear + " / " + sheetMonth + "]");
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
