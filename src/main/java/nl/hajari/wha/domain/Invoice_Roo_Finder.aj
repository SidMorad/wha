package nl.hajari.wha.domain;

import java.lang.SuppressWarnings;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.InvoiceType;
import nl.hajari.wha.domain.Timesheet;

privileged aspect Invoice_Roo_Finder {
    
    @SuppressWarnings("unchecked")
    public static Query Invoice.findInvoicesByTimesheet(Timesheet timesheet) {
        if (timesheet == null) throw new IllegalArgumentException("The timesheet argument is required");
        EntityManager em = Invoice.entityManager();
        Query q = em.createQuery("SELECT Invoice FROM Invoice AS invoice WHERE invoice.timesheet = :timesheet");
        q.setParameter("timesheet", timesheet);
        return q;
    }
    
    @SuppressWarnings("unchecked")
    public static Query Invoice.findInvoicesByTimesheetAndInvoiceTypeEquals(Timesheet timesheet, InvoiceType invoiceType) {
        if (timesheet == null) throw new IllegalArgumentException("The timesheet argument is required");
        if (invoiceType == null) throw new IllegalArgumentException("The invoiceType argument is required");
        EntityManager em = Invoice.entityManager();
        Query q = em.createQuery("SELECT Invoice FROM Invoice AS invoice WHERE invoice.timesheet = :timesheet AND invoice.invoiceType = :invoiceType");
        q.setParameter("timesheet", timesheet);
        q.setParameter("invoiceType", invoiceType);
        return q;
    }
    
}
