package nl.hajari.wha.domain;

import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.Query;

privileged aspect DailyTimesheet_Wha_Entity {

	public void DailyTimesheet.setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String DailyTimesheet.getProjectName() {
		return this.projectName;
	}

	public static Float DailyTimesheet.findTimesheetTotalMonthly(
			Long timesheetId) {
		if (timesheetId == null)
			throw new IllegalArgumentException(
					"An identifier is required to retrieve an instance of Timesheet");
		EntityManager entityManager = DailyTimesheet.entityManager();
		Query query = entityManager
				.createQuery("SELECT SUM(x.dailyTotalDuration) FROM DailyTimesheet x WHERE x.timesheet.id = :timesheetID");
		query.setParameter("timesheetID", timesheetId);

		if (query.getSingleResult() == null) {
			return 0f;
		}

		// query will return double not float !
		Double monthlyTotalDouble = (Double) query.getSingleResult();
		Float montlyTotal = new Float(monthlyTotalDouble);

		return montlyTotal;
	}

	public static Float DailyTimesheet.findTotalDurationByTimesheetIdAndDayDate(Long timesheetId, Date dayDate) {
		if (timesheetId == null)
			throw new IllegalArgumentException("An identifier is required to retrieve an instance of Timesheet");
		EntityManager entityManager = DailyTimesheet.entityManager();
		Query query = entityManager
		.createQuery("SELECT SUM(x.duration) FROM DailyTimesheet x WHERE x.timesheet.id = :timesheetId and x.dayDate= :dayDate");
		query.setParameter("timesheetId", timesheetId);
		query.setParameter("dayDate", dayDate);
		
		if (query.getSingleResult() == null) {
			return 0f;
		}
		
		// query will return double not float !
		Double totalDurationDouble = (Double) query.getSingleResult();
		Float totalDuration = new Float(totalDurationDouble);
		
		return totalDuration;
	}
}
