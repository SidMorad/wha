package nl.hajari.wha.domain;

import java.lang.SuppressWarnings;
import java.util.Date;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.Timesheet;

privileged aspect DailyTimesheet_Roo_Finder {
    
    @SuppressWarnings("unchecked")
    public static Query DailyTimesheet.findDailyTimesheetsByTimesheet(Timesheet timesheet) {
        if (timesheet == null) throw new IllegalArgumentException("The timesheet argument is required");
        EntityManager em = DailyTimesheet.entityManager();
        Query q = em.createQuery("SELECT DailyTimesheet FROM DailyTimesheet AS dailytimesheet WHERE dailytimesheet.timesheet = :timesheet");
        q.setParameter("timesheet", timesheet);
        return q;
    }
    
    @SuppressWarnings("unchecked")
    public static Query DailyTimesheet.findDailyTimesheetsByDayDateAndTimesheet(Date dayDate, Timesheet timesheet) {
        if (dayDate == null) throw new IllegalArgumentException("The dayDate argument is required");
        if (timesheet == null) throw new IllegalArgumentException("The timesheet argument is required");
        EntityManager em = DailyTimesheet.entityManager();
        Query q = em.createQuery("SELECT DailyTimesheet FROM DailyTimesheet AS dailytimesheet WHERE dailytimesheet.dayDate = :dayDate AND dailytimesheet.timesheet = :timesheet");
        q.setParameter("dayDate", dayDate);
        q.setParameter("timesheet", timesheet);
        return q;
    }
    
}
