package nl.hajari.wha.domain;

import java.lang.Long;
import java.lang.String;
import java.util.Date;
import nl.hajari.wha.domain.InvoiceType;
import nl.hajari.wha.domain.Timesheet;

privileged aspect Invoice_Wha_JavaBean {
        
    public boolean Invoice.getReportHeadered() {
        return this.reportHeadered;
    }
    
}
