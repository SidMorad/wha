/*
 * Created on 13/03/2010 - 2:38:58 PM 
 */
package nl.hajari.wha.service.impl;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import nl.hajari.wha.domain.DailyTravel;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.service.DailyTravelService;
import nl.hajari.wha.service.TimesheetService;
import nl.hajari.wha.web.controller.formbean.TimesheetWeeklyFormBean;
import nl.hajari.wha.web.controller.formbean.Week;
import nl.hajari.wha.web.util.DateUtils;
import nl.hajari.wha.web.util.LocaleUtils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 
 * 
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
@Service
public class DailyTravelServiceImpl extends AbstractService implements DailyTravelService {

	@Autowired
	protected TimesheetService timesheetService;

	@Override
	public Float calculateTravelTotalDistance(Long timesheetId) {
		Timesheet timesheet = timesheetService.load(timesheetId);
		Float totalDistance = 0f;
		for (DailyTravel dailyTravel : timesheet.getDailyTravels()) {
			if (dailyTravel.getWithReturn() != null && dailyTravel.getWithReturn() == Boolean.TRUE) {
				totalDistance += dailyTravel.getDistance() * 2;
			} else {
				totalDistance += dailyTravel.getDistance();
			}
		}
		return totalDistance;
	}

	@Override
	public boolean deleteDailyTravelByTimesheet(Timesheet timesheet) {
		List<DailyTravel> dts = DailyTravel.findDailyTravelsByTimesheet(timesheet).getResultList();
		try {
			for (DailyTravel dt : dts) {
				dt.remove();
			}
			return true;
		} catch (Exception e) {
			return false;
		}
	}

	@Override
	public void saveOrUpdateWeeklyTravels(TimesheetWeeklyFormBean bean, Timesheet timesheet) {
		Map<Integer, Week> weeks = DateUtils.getCurrentMonthWeeks();
		Week week = weeks.get(bean.getWeek());
		if (null == week) {
			logger.warn("No week is selected for week travels [" + timesheet + "] to update.");
			return;
		}
		Date startDate = week.getStartDate();
		Calendar c = Calendar.getInstance(LocaleUtils.getCurrentLocale());
		c.setTime(startDate);
		logger.debug("Processing weekly travels " + bean + " with days (" + Arrays.toString(bean.getDays()) + ")");
		Float working = bean.getDay1();
		int i = c.get(Calendar.DAY_OF_WEEK);
		for (int count = 1; count <= 7; ++count) {
			Date date = c.getTime();
			logger.debug("Checking working [" + working + "] with dates (" + date + ", " + week.getEndDate() + ")");
			boolean inWeek = date.getTime() <= week.getEndDate().getTime();
			if (working > 0f && inWeek) {
				DailyTravel dt = findDailyTravel(timesheet, date);
				if (null == dt) {
					dt = new DailyTravel();
					dt.setDayDate(date);
					dt.setTimesheet(timesheet);
					dt.setDestination(bean.getDestination());
					dt.setOrigin(bean.getOrigin());
					dt.setDistance(working);
					dt.setWithReturn(bean.getWithReturn());
					dt.setComment(bean.getComment());
					dt.persist();
					dt.flush();
				} else {
					dt.setDestination(bean.getDestination());
					dt.setOrigin(bean.getOrigin());
					dt.setDistance(working);
					dt.setWithReturn(bean.getWithReturn());
					dt.setComment(bean.getComment());
					dt.merge();
					dt.flush();
				}
				logger.debug("Created or updated daily timesheet: " + dt);
			}
			c.add(Calendar.DAY_OF_MONTH, 1);
			++i;
			if (7 < i) {
				i = 1;
			}
		}
	}

	private DailyTravel findDailyTravel(Timesheet timesheet, Date date) {
		try {
			return (DailyTravel) DailyTravel.findDailyTravelsByDayDateAndTimesheet(date, timesheet).getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}
}
