package nl.hajari.wha.domain;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.Timesheet;

privileged aspect Invoice_Roo_Finder {
    
    public static Query Invoice.findInvoicesByTimesheet(Timesheet timesheet) {    
        if (timesheet == null) throw new IllegalArgumentException("The timesheet argument is required");        
        EntityManager em = Invoice.entityManager();        
        Query q = em.createQuery("SELECT Invoice FROM Invoice AS invoice WHERE invoice.timesheet = :timesheet");        
        q.setParameter("timesheet", timesheet);        
        return q;        
    }    
    
}
