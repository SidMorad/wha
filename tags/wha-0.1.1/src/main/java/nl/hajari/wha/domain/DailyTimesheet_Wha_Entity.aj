package nl.hajari.wha.domain;

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
		// we new Float with double value. TODO: check if this is right thing to
		// do.
		Float montlyTotal = new Float(monthlyTotalDouble);

		return montlyTotal;
	}
}
