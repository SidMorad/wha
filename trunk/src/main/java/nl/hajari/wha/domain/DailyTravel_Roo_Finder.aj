package nl.hajari.wha.domain;

import java.util.Date;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.Timesheet;

privileged aspect DailyTravel_Roo_Finder {
    
    public static Query DailyTravel.findDailyTravelsByTimesheet(Timesheet timesheet) {    
        if (timesheet == null) throw new IllegalArgumentException("The timesheet argument is required");        
        EntityManager em = DailyTravel.entityManager();        
        Query q = em.createQuery("SELECT DailyTravel FROM DailyTravel AS dailytravel WHERE dailytravel.timesheet = :timesheet");        
        q.setParameter("timesheet", timesheet);        
        return q;        
    }
    
    public static Query DailyTravel.findDailyTravelsByDayDateAndTimesheet(Date dayDate, Timesheet timesheet) {
        if (dayDate == null) throw new IllegalArgumentException("The dayDate argument is required");        
        if (timesheet == null) throw new IllegalArgumentException("The timesheet argument is required");        
        EntityManager em = DailyTravel.entityManager();
        Query q = em.createQuery("SELECT DailyTravel FROM DailyTravel AS dailytravel WHERE dailytravel.dayDate = :dayDate AND dailytravel.timesheet = :timesheet");
        q.setParameter("dayDate", dayDate);        
        q.setParameter("timesheet", timesheet);        
        return q;
    }
    
}
