package nl.hajari.wha.domain;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.transaction.annotation.Transactional;

privileged aspect Timesheet_Wha_Entity {

	@Transactional
	public static int Timesheet.updateTimesheetTotalMonthly(Long id, Float total) {
		EntityManager entityManager = Timesheet.entityManager();
		Query query = entityManager.createQuery("UPDATE Timesheet t SET t.monthlyTotal = :total WHERE t.id = :id");
		query.setParameter("total", total);
		query.setParameter("id", id);
		return query.executeUpdate();
	}
	
}
