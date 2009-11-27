package nl.hajari.wha.domain;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.Timesheet;

privileged aspect DailyTimesheet_Roo_Finder {
    
    public static Query DailyTimesheet.findDailyTimesheetsByTimesheet(Timesheet timesheet) {    
        if (timesheet == null) throw new IllegalArgumentException("The timesheet argument is required");        
        EntityManager em = DailyTimesheet.entityManager();        
        Query q = em.createQuery("SELECT DailyTimesheet FROM DailyTimesheet AS dailytimesheet WHERE dailytimesheet.timesheet = :timesheet");        
        q.setParameter("timesheet", timesheet);        
        return q;        
    }    
    
}
