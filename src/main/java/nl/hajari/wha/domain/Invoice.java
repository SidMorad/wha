package nl.hajari.wha.domain;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import nl.hajari.wha.domain.InvoiceType;
import javax.persistence.Enumerated;
import javax.validation.constraints.NotNull;

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
@Entity
@RooJavaBean
@RooToString
@RooEntity(finders = { "findInvoicesByTimesheet", "findInvoicesByTimesheetAndInvoiceTypeEquals" })
public class Invoice {

    @NotNull
    @Column(nullable = false)
    private String invoiceId;

    @NotNull
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "S-")
    @Column(nullable = false)
    private Date invoiceDate;

    @NotNull
    @Column(nullable = false)
    private Long serialNumber;

    @ManyToOne(targetEntity = Timesheet.class)
    @JoinColumn(name = "timesheet_id", nullable = false)
    private Timesheet timesheet;

    @NotNull
    @Column(nullable = true)
    private String opdracht;

    @NotNull
    @Enumerated
    private InvoiceType invoiceType;
}
