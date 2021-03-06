package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect Invoice_Roo_ToString {
    
    public String Invoice.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Id: ").append(getId()).append(", ");
        sb.append("Version: ").append(getVersion()).append(", ");
        sb.append("InvoiceId: ").append(getInvoiceId()).append(", ");
        sb.append("InvoiceDate: ").append(getInvoiceDate()).append(", ");
        sb.append("SerialNumber: ").append(getSerialNumber()).append(", ");
        sb.append("Timesheet: ").append(getTimesheet()).append(", ");
        sb.append("Opdracht: ").append(getOpdracht()).append(", ");
        sb.append("InvoiceType: ").append(getInvoiceType()).append(", ");
        sb.append("ReportHeadered: ").append(isReportHeadered());
        return sb.toString();
    }
    
}
