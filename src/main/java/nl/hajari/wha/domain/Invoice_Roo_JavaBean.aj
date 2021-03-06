package nl.hajari.wha.domain;

import java.lang.Long;
import java.lang.String;
import java.util.Date;
import nl.hajari.wha.domain.InvoiceType;
import nl.hajari.wha.domain.Timesheet;

privileged aspect Invoice_Roo_JavaBean {
    
    public String Invoice.getInvoiceId() {
        return this.invoiceId;
    }
    
    public void Invoice.setInvoiceId(String invoiceId) {
        this.invoiceId = invoiceId;
    }
    
    public Date Invoice.getInvoiceDate() {
        return this.invoiceDate;
    }
    
    public void Invoice.setInvoiceDate(Date invoiceDate) {
        this.invoiceDate = invoiceDate;
    }
    
    public Long Invoice.getSerialNumber() {
        return this.serialNumber;
    }
    
    public void Invoice.setSerialNumber(Long serialNumber) {
        this.serialNumber = serialNumber;
    }
    
    public Timesheet Invoice.getTimesheet() {
        return this.timesheet;
    }
    
    public void Invoice.setTimesheet(Timesheet timesheet) {
        this.timesheet = timesheet;
    }
    
    public String Invoice.getOpdracht() {
        return this.opdracht;
    }
    
    public void Invoice.setOpdracht(String opdracht) {
        this.opdracht = opdracht;
    }
    
    public InvoiceType Invoice.getInvoiceType() {
        return this.invoiceType;
    }
    
    public void Invoice.setInvoiceType(InvoiceType invoiceType) {
        this.invoiceType = invoiceType;
    }
    
    public boolean Invoice.isReportHeadered() {
        return this.reportHeadered;
    }
    
    public void Invoice.setReportHeadered(boolean reportHeadered) {
        this.reportHeadered = reportHeadered;
    }
    
}
