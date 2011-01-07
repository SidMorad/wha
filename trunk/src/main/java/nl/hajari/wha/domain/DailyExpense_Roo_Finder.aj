package nl.hajari.wha.domain;

import java.lang.SuppressWarnings;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.Timesheet;

privileged aspect DailyExpense_Roo_Finder {
    
    @SuppressWarnings("unchecked")
    public static Query DailyExpense.findDailyExpensesByTimesheet(Timesheet timesheet) {
        if (timesheet == null) throw new IllegalArgumentException("The timesheet argument is required");
        EntityManager em = DailyExpense.entityManager();
        Query q = em.createQuery("SELECT DailyExpense FROM DailyExpense AS dailyexpense WHERE dailyexpense.timesheet = :timesheet");
        q.setParameter("timesheet", timesheet);
        return q;
    }
    
}
