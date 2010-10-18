package nl.hajari.wha.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import nl.hajari.wha.domain.Constants;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.ConstantsService;
import nl.hajari.wha.service.DailyTimesheetService;
import nl.hajari.wha.service.ProjectService;
import nl.hajari.wha.web.controller.formbean.TimesheetWeeklyFormBean;
import nl.hajari.wha.web.controller.formbean.Week;
import nl.hajari.wha.web.util.DateUtils;
import nl.hajari.wha.web.util.LocaleUtils;

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

	@Autowired
	protected ProjectService projectService;

	@Transactional(readOnly = false)
	public DailyTimesheet createDailyTimesheet(DailyTimesheet dt,
			Long timesheetId) {
		if (dt == null) {
			throw new IllegalArgumentException("A dailyTimesheet is required");
		}
		if (timesheetId == null) {
			throw new IllegalStateException(
					"Month Travel view requires current Timesheet. Timesheet ID is null.");
		}
		Timesheet timesheet = Timesheet.findTimesheet(timesheetId);
		dt.setTimesheet(timesheet);

		/*
		 * NEW RULE: TOTAL DAILY DURATION = WORKING HOURS we'll use other data
		 * in future reports and calculations
		 */
		/*
		 * // Check dailyTotalDuration to be positive if (dt.getDuration() >
		 * dt.getDurationOffs() + dt.getDurationSickness()) { //
		 * dailyTotalDuration = duration - durationOffs - durationSickness
		 * dt.setDailyTotalDuration(dt.getDuration() - dt.getDurationOffs() -
		 * dt.getDurationSickness()); } else { dt.setDailyTotalDuration(0f); }
		 */
		refineDailyTimesheetBasedOnProject(dt);
		dt.setDailyTotalDuration(dt.getDuration());
		dt.persist();
		dt.flush();
		// now we update monthlyTotalDuration in timesheet entity
		Timesheet.updateTimesheetTotalMonthly(timesheetId, DailyTimesheet.findTimesheetTotalMonthly(timesheetId));
		return dt;
	}

	@Transactional(readOnly = false)
	public DailyTimesheet createDailyTimesheet(DailyTimesheet dailyTimesheet) {
		Long timesheetId = dailyTimesheet.getTimesheet().getId();
		return createDailyTimesheet(dailyTimesheet, timesheetId);
	}

	@Transactional(readOnly = false)
	public DailyTimesheet updateDailyTimesheet(DailyTimesheet dt) {
		if (dt == null) {
			throw new IllegalArgumentException("A dailytimesheet is required");
		}
		/*
		 * NEW RULE: TOTAL DAILY DURATION = WORKING HOURS we'll use other data
		 * in future reports and calculations
		 */
		/*
		 * // Check dailyTotalDuration to be positive if (dt.getDuration() >
		 * dt.getDurationOffs() + dt.getDurationSickness()) { // calculate
		 * dailyTotalDuration = duration - durationOffs - // durationSickness
		 * dt.setDailyTotalDuration(dt.getDuration() - dt.getDurationOffs() -
		 * dt.getDurationSickness()); } else { dt.setDailyTotalDuration(0f); }
		 */
		dt.setDailyTotalDuration(dt.getDuration());
		dt.merge();
		dt.flush();
		// now we update monthlyTotal in Timesheet
		Long tsId = dt.getTimesheet().getId();
		Float total = DailyTimesheet.findTimesheetTotalMonthly(tsId);
		logger.debug("Updating timesheet[" + tsId + "] to total [" + total + "]");
		Timesheet.updateTimesheetTotalMonthly(tsId, total);
		return dt;
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
		return getDailyTimesheetListForReportPerProject(dailies);
	}
	
	public List<DailyTimesheet> getDailyTimesheetListForReportPerProject(List<DailyTimesheet> dailies) {
		List<DailyTimesheet> finalTimesheetList = new ArrayList<DailyTimesheet>();

		// listOfTheOnes is a list of 'project' that we already 'group by' them
		List<Project> listOfTheOnes = new ArrayList<Project>();
		for (DailyTimesheet dt : dailies) {
			DailyTimesheet newDt = new DailyTimesheet(dt.getTimesheet(), 0f, 0f, 0f, 0f, 0f);
			// check if theOne is not in the list
			Project theOne = dt.getProject();
			if (!listOfTheOnes.contains(theOne)) {
				for (DailyTimesheet dt2 : dailies) {
					if (theOne.equals(dt2.getProject())) {
						newDt.setProject(theOne);
						newDt.setDuration(newDt.getDuration() + dt2.getDuration());
						newDt.setDurationOffs(newDt.getDurationOffs() + dt2.getDurationOffs());
						newDt.setDurationTraining(newDt.getDurationTraining() + dt2.getDurationTraining());
						newDt.setDurationSickness(newDt.getDurationSickness() + dt2.getDurationSickness());
						newDt.setDailyTotalDuration(newDt.getDailyTotalDuration() + dt2.getDailyTotalDuration());
					}
				}
				finalTimesheetList.add(newDt);
				listOfTheOnes.add(theOne);
			}
		}

		return finalTimesheetList;
	}
	
	public DailyTimesheet getTotalDailyTimesheetPerMonthBetweenTwoDates(List<DailyTimesheet> dailes, Date from, Date to) {
		dailes = getDailyTimesheetsBetweenDates(dailes, from, to);
		if (dailes.size() > 0) {
			DailyTimesheet newDt = new DailyTimesheet(null, 0f, 0f, 0f, 0f, 0f);
			for (DailyTimesheet dt : dailes) {
				newDt.setTimesheet(dt.getTimesheet());
				newDt.setProject(dt.getProject());
				newDt.setDayDate(dt.getDayDate());
				newDt.setDuration(newDt.getDuration() + dt.getDuration());
				newDt.setDurationOffs(newDt.getDurationOffs() + dt.getDurationOffs());
				newDt.setDurationTraining(newDt.getDurationTraining() + dt.getDurationTraining());
				newDt.setDurationSickness(newDt.getDurationSickness() + dt.getDurationSickness());
				newDt.setDailyTotalDuration(newDt.getDailyTotalDuration() + dt.getDailyTotalDuration());
			}
			return newDt;
		}
		return null;
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

	/*
	public Float cacluateSubtotalForInvocieReport(List<DailyTimesheet> dts, Float hourlyWage) {
		Float totalDuration = 0f;
		for (DailyTimesheet dailyTimesheet : dts) {
			// Note 1: getDailyTotalDuration is actually total duration of
			// month! for mentioned project
			// Note 2: we expect employees work with one project per month but
			// we also can support more than one
			totalDuration += dailyTimesheet.getDailyTotalDuration();
		}
		Float subtotal = totalDuration * hourlyWage;
		return subtotal;
	}
	*/

	/*
	public Float calcuateTotalTax(Float amount) {
		Constants vatRatioCons = constantsService.findByKey(ConstantsService.CONST_KEY_EXPENSE_VAT);
		Float vatRatio = Float.valueOf(vatRatioCons.getValue());
		Float total = amount * vatRatio;
		return total;
	}
	*/

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

	@Transactional(readOnly = false)
	@Override
	public void saveOrUpdateWeeklyTimesheet(TimesheetWeeklyFormBean bean, Timesheet timesheet, Project project) {
		Map<Integer, Week> weeks = DateUtils.getCurrentMonthWeeks();
		Week week = weeks.get(bean.getWeek());
		if (null == week) {
			logger.warn("No week is selected for timesheet [" + timesheet + "] to update.");
			return;
		}
		Date startDate = week.getStartDate();
		Calendar c = Calendar.getInstance(LocaleUtils.getCurrentLocale());
		c.setTime(startDate);
		Float[] days = bean.getDays();
		logger.debug("Processing a weekly timesheet " + bean + " with days (" + Arrays.toString(days) + ")");
		int i = c.get(Calendar.DAY_OF_WEEK);
		for (int count = 1; count <= 7; ++count) {
			Date date = c.getTime();
			Float working = days[i - 1];
			logger.debug("Checking working [" + working + "] with dates (" + date + ", " + week.getEndDate() + ")");
			boolean inWeek = date.getTime() <= week.getEndDate().getTime();
			if (working > 0f && inWeek) {
				DailyTimesheet dt = findDailyTimesheet(timesheet, date);
				if (null == dt) {
					dt = new DailyTimesheet();
					dt.setDayDate(date);
					dt.setProject(project);
					dt.setTimesheet(timesheet);
					dt.setDuration(working);
					dt.setDailyTotalDuration(0f);
					dt.setDurationOffs(0f);
					dt.setDurationSickness(0f);
					dt.setDurationTraining(0f);
					createDailyTimesheet(dt);
				} else {
					dt.setDuration(working);
					dt.setProject(project);
					updateDailyTimesheet(dt);
				}
				logger.debug("Created or updated daily timesheet: " + dt);
			} else if (working == 0f && inWeek) {
				// maybe is updating a currently stored daily time sheet now
				// with 0 hours so it means
				// 1. to delete the daily time sheet!
				// 2. leave the daily time sheet ALONE!

				// we choose 2 at this moment

				// this is for option 1
				/*
				 * DailyTimesheet dt = findDailyTimesheet(timesheet, date); if
				 * (null != dt) { logger.debug("Deleting daily timesheet " + dt
				 * + " since it says to have 0 working hours.");
				 * deleteDailyTimesheet(dt); }
				 */
			}
			c.add(Calendar.DAY_OF_MONTH, 1);
			++i;
			if (7 < i) {
				i = 1;
			}
		}
	}

	private DailyTimesheet findDailyTimesheet(Timesheet timesheet, Date date) {
		try {
			return (DailyTimesheet) DailyTimesheet.findDailyTimesheetsByDayDateAndTimesheet(date, timesheet)
					.getSingleResult();
		} catch (Exception e) {
		}
		return null;
	}

	private void refineDailyTimesheetBasedOnProject(DailyTimesheet dt) {
		Float duration = dt.getDuration();
		Float offs = dt.getDurationOffs();
		Float sickness = dt.getDurationSickness();
		Float training = dt.getDurationTraining();
		Project p = dt.getProject();
		Project defaultOffTimeProject = projectService.getDefaultOffTimeProject();
		Project defaultSicknessProject = projectService.getDefaultSicknessProject();
		if (!p.equals(defaultOffTimeProject) && !p.equals(defaultSicknessProject)) {
			return;
		}
		if (p.equals(defaultSicknessProject)) {
			if (sickness == 0f) {
				if (offs > 0) {
					dt.setDurationSickness(offs);
				}
				if (training > 0) {
					dt.setDurationSickness(training);
				}
				if (duration > 0) {
					dt.setDurationSickness(duration);
				}
			}
			dt.setDuration(0f);
			dt.setDurationOffs(0f);
			dt.setDurationTraining(0f);
			return;
		}
		if (p.equals(defaultOffTimeProject)) {
			if (offs == 0f) {
				if (sickness > 0) {
					dt.setDurationOffs(sickness);
				}
				if (training > 0) {
					dt.setDurationOffs(training);
				}
				if (duration > 0) {
					dt.setDurationOffs(duration);
				}
			}
			dt.setDuration(0f);
			dt.setDurationSickness(0f);
			dt.setDurationTraining(0f);
			return;
		}
	}

	private List<DailyTimesheet> getDailyTimesheetsBetweenDates(List<DailyTimesheet> dailyTimesheets, Date from, Date to) {
    	List<DailyTimesheet> list = new ArrayList<DailyTimesheet>();
    	for (DailyTimesheet dailyTimesheet : dailyTimesheets) {
    		Date date = dailyTimesheet.getDayDate();
    		if ((date.after(from) || date.equals(from)) && (date.before(to) || date.equals(to)) ) {
    			list.add(dailyTimesheet);
    		}
		}
    	return list;
    }
}
