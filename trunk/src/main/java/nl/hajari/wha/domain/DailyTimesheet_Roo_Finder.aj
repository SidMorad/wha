package nl.hajari.wha.domain;

import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.Query;

privileged aspect DailyTimesheet_Roo_Finder {

	public static Query DailyTimesheet.findDailyTimesheetsByTimesheet(Timesheet timesheet) {
		if (timesheet == null)
			throw new IllegalArgumentException("The timesheet argument is required");
		EntityManager em = DailyTimesheet.entityManager();
		Query q = em
				.createQuery("SELECT DailyTimesheet FROM DailyTimesheet AS dailytimesheet WHERE dailytimesheet.timesheet = :timesheet");
		q.setParameter("timesheet", timesheet);
		return q;
	}

	public static Query DailyTimesheet.findDailyTimesheetByDayDateAndTimesheet(Date dayDate, Timesheet timesheet) {
		Query query;
		try {
			EntityManager em = DailyTimesheet.entityManager();
			query = em
					.createQuery("SELECT DailyTimesheet FROM DailyTimesheet AS dailytimesheet WHERE dailytimesheet.dayDate = :dayDate AND dailytimesheet.timesheet = :timesheet");
			query.setParameter("dayDate", dayDate);
			query.setParameter("timesheet", timesheet);
			return query;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

}
