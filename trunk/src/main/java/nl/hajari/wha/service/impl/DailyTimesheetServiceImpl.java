package nl.hajari.wha.service.impl;

import java.util.ArrayList;
import java.util.List;

import nl.hajari.wha.domain.Constants;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.ConstantsService;
import nl.hajari.wha.service.DailyTimesheetService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * Default implementation of business logics in DailyTimesheet.
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 * @author Behrooz Nobakht
 **/
@Service
public class DailyTimesheetServiceImpl extends AbstractService implements DailyTimesheetService {

	@Autowired
	protected ConstantsService constantsService;
	
	@Transactional(readOnly = false)
	public DailyTimesheet createDailyTimesheet(DailyTimesheet dailyTimesheet,
			Long timesheetId) {
		if (dailyTimesheet == null) {
			throw new IllegalArgumentException("A dailyTimesheet is required");
		}
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
			DailyTimesheet newDt = new DailyTimesheet(timesheet, 0f, 0f, 0f, 0f);
			// check if theOne is not in the list
			Project theOne = dt.getProject();
			if (!listOfTheOnes.contains(theOne)) {
				for (DailyTimesheet dt2 : dailies) {
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

	public boolean validateDailyHours(DailyTimesheet dailyTimesheet, Long timesheetId) {
		Float twentyFour = new Float(24f);
		if (dailyTimesheet.getDuration() > twentyFour) {
			return true;
		}
		Float totalDuration = DailyTimesheet.findTotalDurationByTimesheetIdAndDayDate(timesheetId, dailyTimesheet
				.getDayDate());
		if (dailyTimesheet.getDuration() + totalDuration > twentyFour) {
			return true;
		}
		return false;
	}

	public Float cacluateSubtotalForInvocieReport(List<DailyTimesheet> dts, Float hourlyWage) {
		Float totalDuration = 0f;
		for (DailyTimesheet dailyTimesheet : dts) {
			// Note 1: getDailyTotalDuration is actually total duration of month! for mentioned project 
			// Note 2: we expect employees work with one project per month but we also can support more than one  
			totalDuration += dailyTimesheet.getDailyTotalDuration();
		}
		Float subtotal = totalDuration * hourlyWage;
		return subtotal;
	}

	public Float calcuateTotalTax(Float amount) {
		Constants vatRatioCons = constantsService.findByKey(ConstantsService.CONST_KEY_SALARY_TAX_RATIO);
		Float vatRatio = Float.valueOf(vatRatioCons.getValue());
		Float total = amount * vatRatio;
		return total;
	}

	@Override
	public boolean deleteDailyTimesheetByTimesheet(Timesheet timesheet) {
		List<DailyTimesheet> dts = DailyTimesheet.findDailyTimesheetsByTimesheet(timesheet).getResultList();
		try {
			for (DailyTimesheet dt : dts) {
				dt.remove();
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}

}
