package nl.hajari.wha.domain;

import javax.persistence.EntityManager;
import javax.persistence.Query;

privileged aspect Timesheet_Wha_Finder {
    
    public static Query Timesheet.findAllTimesheetYears() {
    	EntityManager em = Timesheet.entityManager();
    	Query q = em.createQuery("SELECT DISTINCT t.sheetYear FROM Timesheet AS t");
    	return q;
    }
 
     public static Query Timesheet.findEditableTimesheetsByEmployee(Employee employee) {
    	if (employee == null) throw new IllegalArgumentException("The employee argument is required");
    	EntityManager em = Timesheet.entityManager();
    	Query q = em.createQuery("SELECT Timesheet FROM Timesheet AS timesheet WHERE timesheet.employee = :employee AND timesheet.editable = :status");
    	q.setParameter("employee", employee);
    	q.setParameter("status", true);
    	return q;
    }
       
}
