package nl.hajari.wha.domain;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.security.context.SecurityContextHolder;
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
	
	public static Timesheet Timesheet.getCurrentEmployeeCurrentMonthTimesheet() {
		SecurityContextHolder.getContext().getAuthentication().getName();
		return null;
	}
	
}
