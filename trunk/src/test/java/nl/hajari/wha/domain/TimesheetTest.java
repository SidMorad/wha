package nl.hajari.wha.domain;

import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:/test/spring/applicationContext-test-dao.xml")
public class TimesheetTest {

	@Test
	public void testFindAllTimesheetsByEmployeeAndSheetMonthAndSheetYearBetween() {
		Employee employee = Employee.findEmployee(1L);

		// Test finder with same year and fromMonth < toMonth
		List<Timesheet> timesheets = Timesheet.findAllTimesheetsByEmployeeAndSheetMonthAndSheetYearBetween(employee, 2010, 1, 2010, 11).getResultList();
		Assert.assertEquals(2, timesheets.size());

		// Test finder with same year and fromMonth > toMonth
		List<Timesheet> timesheets2 = Timesheet.findAllTimesheetsByEmployeeAndSheetMonthAndSheetYearBetween(employee, 2010, 11, 2010, 1).getResultList();
		Assert.assertEquals(0, timesheets2.size());
		
		// Test finder with different year fromYear < toYear
		// TODO figure it a way to limit the result with fromMonth and toMonth
		List<Timesheet> timesheets3 = Timesheet.findAllTimesheetsByEmployeeAndSheetMonthAndSheetYearBetween(employee, 2009, 1, 2010, 1).getResultList();
		Assert.assertEquals(4, timesheets3.size());

		// Test finder with different year fromYear > toYear
		List<Timesheet> timesheets4 = Timesheet.findAllTimesheetsByEmployeeAndSheetMonthAndSheetYearBetween(employee, 2010, 1, 2009, 1).getResultList();
		Assert.assertEquals(0, timesheets4.size());
		
	}
}
