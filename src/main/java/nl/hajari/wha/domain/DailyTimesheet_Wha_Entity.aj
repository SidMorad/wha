package nl.hajari.wha.domain;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

privileged aspect DailyTimesheet_Wha_Entity {

	public static Float DailyTimesheet.findTimesheetTotalMonthly(Long timesheetId) {
		if (timesheetId == null) throw new IllegalArgumentException("An identifier is required to retrieve an instance of Timesheet");
		EntityManager entityManager = DailyTimesheet.entityManager(); 
		Query query = entityManager.createQuery("SELECT x.dailyTotalDuration FROM DailyTimesheet x WHERE x.timesheet.id = :timesheetID");
		query.setParameter("timesheetID", timesheetId);
		List<Float> dailies = query.getResultList();
		Float monthlyTotal = 0f;
		for (Float dailyTotalDuration : dailies) {
			monthlyTotal = monthlyTotal + dailyTotalDuration; 
		}
		return monthlyTotal;
	}
}
