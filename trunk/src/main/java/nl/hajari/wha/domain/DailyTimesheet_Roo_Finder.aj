package nl.hajari.wha.domain;

import javax.persistence.EntityManager;
import javax.persistence.Query;

privileged aspect DailyTimesheet_Roo_Finder {

	public static Query DailyTimesheet.findDailyTimesheetsForTimesheet(Timesheet timesheet) {
		EntityManager em = DailyTimesheet.entityManager();
		try {
			System.out.println("ooooo \n timesheet[" + timesheet + "] \n oooooo");
			Query query = em
					.createQuery("SELECT DailyTimesheet FROM DailyTimesheet AS d WHERE d.timesheet = :timesheet");
			query.setParameter("timesheet", timesheet);
			return query;
		} catch (RuntimeException re) {
			re.printStackTrace();
			throw re;
		}
	}

}
