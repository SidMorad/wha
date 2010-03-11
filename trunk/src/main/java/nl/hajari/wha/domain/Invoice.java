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

/**
 * 
 * 
 * @author Behrooz Nobakht [behrooz dot nobakht at gmail dot com]
 * @author <a href="mailto:saeid3@gmail.com">Saeid Moradi</a>
 */
@Entity
@RooJavaBean
@RooToString
@RooEntity(finders = { "findInvoicesByTimesheet" })
public class Invoice {

    @Column(nullable = false)
    private String invoiceId;

    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(style = "S-")
    @Column(nullable = false)
    private Date invoiceDate;

    @Column(nullable = false)
    private Long serialNumber;

    @ManyToOne(targetEntity = Timesheet.class)
    @JoinColumn(name = "timesheet_id", nullable = false)
    private Timesheet timesheet;
    
    @Column(nullable = true)
    private String opdracht;

}
