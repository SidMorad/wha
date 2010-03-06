package nl.hajari.wha.domain;

import javax.persistence.EntityManager;
import javax.persistence.Query;

privileged aspect Timesheet_Wha_Finder {
    
    public static Query Timesheet.findAllTimesheetYears() {
    	EntityManager em = Timesheet.entityManager();
    	Query q = em.createQuery("SELECT DISTINCT t.sheetYear FROM Timesheet AS t");
    	return q;
    }
    
}
