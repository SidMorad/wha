package nl.hajari.wha.service;

import javax.servlet.http.HttpServletRequest;

import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Timesheet;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Default implementation of business logics in DailyTimesheet.
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 **/
@Service
public class DailyTimesheetService {

	protected final Log logger = LogFactory.getLog(getClass());

	@Transactional(readOnly = false)
	public DailyTimesheet createDailyTimesheet(DailyTimesheet dailyTimesheet,
			HttpServletRequest request) {
		if (dailyTimesheet == null) {
			throw new IllegalArgumentException("A dailyTimesheet is required");
		}

		Long timesheetId = (Long) request.getSession().getAttribute(
				Timesheet.TIMESHEET_ID);
		if (timesheetId == null) {
			throw new IllegalStateException(
					"Month Travel view requires current Timesheet. Timesheet ID is null.");
		}
		Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		dailyTimesheet.setTimesheet(timesheet);

		// calculate dailyTotalDuration = duration - durationOffs
		dailyTimesheet.setDailyTotalDuration(dailyTimesheet.getDuration()
				- dailyTimesheet.getDurationOffs());
		dailyTimesheet.persist();
		dailyTimesheet.flush();
		// now we update monthlyTotalDuration in timesheet entity
		Timesheet.updateTimesheetTotalMonthly(timesheetId, DailyTimesheet
				.findTimesheetTotalMonthly(timesheetId));
		return dailyTimesheet;
	}

	@Transactional(readOnly = false)
	public DailyTimesheet createDailyTimesheet(DailyTimesheet dailyTimesheet) {
		if (dailyTimesheet == null) {
			throw new IllegalArgumentException("A dailyTimesheet is required");
		}
		
		// calculate dailyTotalDuration = duration - durationOffs
		dailyTimesheet.setDailyTotalDuration(dailyTimesheet.getDuration()
				- dailyTimesheet.getDurationOffs());
		dailyTimesheet.persist();
		dailyTimesheet.flush();
		Long timesheetId = dailyTimesheet.getTimesheet().getId();
		// now we update monthlyTotalDuration in timesheet entity
		Timesheet.updateTimesheetTotalMonthly(timesheetId, DailyTimesheet
				.findTimesheetTotalMonthly(timesheetId));
		return dailyTimesheet;
	}

	@Transactional(readOnly = false)
	public DailyTimesheet updateDailyTimesheet(DailyTimesheet dailyTimesheet) {
		if (dailyTimesheet == null) {
			throw new IllegalArgumentException("A dailytimesheet is required");
		}
		// calculate dailyTotalDuration = duration - durationOffs
		dailyTimesheet.setDailyTotalDuration(dailyTimesheet.getDuration()
				- dailyTimesheet.getDurationOffs());
		dailyTimesheet.merge();
		dailyTimesheet.flush();
		// now we update monthlyTotal in Timesheet
		Long tsId = dailyTimesheet.getTimesheet().getId();
		Float total = DailyTimesheet.findTimesheetTotalMonthly(tsId);
		logger.debug("Updating timesheet[" + tsId + "] to total [" + total + "]");
		Timesheet.updateTimesheetTotalMonthly(tsId, total);
		return dailyTimesheet;
	}

	@Transactional(readOnly = false)
	public Long deleteDailyTimesheet(DailyTimesheet dailyTimesheet) {
		Long tsId = dailyTimesheet.getTimesheet().getId();
		dailyTimesheet.remove();

		// now we update monthlyTotal in Timesheet table
		Timesheet.updateTimesheetTotalMonthly(tsId, DailyTimesheet.findTimesheetTotalMonthly(tsId));
		return tsId;
	}
	
}
