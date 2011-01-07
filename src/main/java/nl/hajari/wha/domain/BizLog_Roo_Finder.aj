package nl.hajari.wha.domain;

import java.lang.SuppressWarnings;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.Timesheet;

privileged aspect BizLog_Roo_Finder {
    
    @SuppressWarnings("unchecked")
    public static Query BizLog.findBizLogsByTimesheet(Timesheet timesheet) {
        if (timesheet == null) throw new IllegalArgumentException("The timesheet argument is required");
        EntityManager em = BizLog.entityManager();
        Query q = em.createQuery("SELECT BizLog FROM BizLog AS bizlog WHERE bizlog.timesheet = :timesheet");
        q.setParameter("timesheet", timesheet);
        return q;
    }
    
}
