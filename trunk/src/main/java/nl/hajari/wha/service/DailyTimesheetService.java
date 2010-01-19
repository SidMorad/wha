package nl.hajari.wha.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Project;
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
	
	public List<DailyTimesheet> getDailyTimesheetListForReportPerProject(Long timesheetId) {
		Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		List<DailyTimesheet> dailies = timesheet.getDailyTimesheetsSortedList();
		
		List<DailyTimesheet> finalTimesheetList = new ArrayList<DailyTimesheet>();
		
		// listOfTheOnes is a list of 'project' that we already 'group by' them
		List<Project> listOfTheOnes = new ArrayList<Project>();
		for (DailyTimesheet dt : dailies) {
			DailyTimesheet newDt = new DailyTimesheet(timesheet,0f,0f,0f,0f);
			//check if theOne is not in the list
			Project theOne = dt.getProject();
			if (!listOfTheOnes.contains(theOne)) {
				for (DailyTimesheet dt2: dailies) {
					if (theOne.equals(dt2.getProject())) {
						newDt.setProject(theOne);
						newDt.setDuration(newDt.getDuration() + dt2.getDuration());
						newDt.setDurationOffs(newDt.getDurationOffs() + dt2.getDurationOffs());
						newDt.setDurationTraining(newDt.getDurationTraining() + dt2.getDurationTraining());
						newDt.setDailyTotalDuration(newDt.getDailyTotalDuration() + dt2.getDailyTotalDuration());
					}
				}
				finalTimesheetList.add(newDt);
				listOfTheOnes.add(theOne);
			}
		}
		
		return finalTimesheetList;
	}
	
	public boolean checkIfDurationIsMoreThan24(DailyTimesheet dailyTimesheet, HttpServletRequest request){
		Float twentyFour = new Float(24f);
		if (dailyTimesheet.getDuration() > twentyFour) {
			return true;
		}
		Long timesheetId = (Long) request.getSession().getAttribute(Timesheet.TIMESHEET_ID);
		Float totalDuration = DailyTimesheet.findTotalDurationByTimesheetIdAndDayDate(timesheetId, dailyTimesheet.getDayDate());
		if (dailyTimesheet.getDuration() + totalDuration > twentyFour) {
			return true;
		}		
		return false;
	}
	
}
