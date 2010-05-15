package nl.hajari.wha.domain;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import nl.hajari.wha.web.validator.FloatPositive;
import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;

@Entity
@RooJavaBean
@RooToString
@RooEntity(finders = { "findDailyTravelsByTimesheet","findDailyTravelsByDayDateAndTimesheet" })
public class DailyTravel {

    @NotNull
    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    private Date dayDate;

    @NotNull
    @Size(max = 45)
    @Column(nullable = false, length = 45)
    private String origin;

    @NotNull
    @Size(max = 45)
    @Column(nullable = false, length = 45)
    private String destination;

    private Boolean withReturn;

    @NotNull
    @FloatPositive
    @Column(nullable = false)
    private Float distance;

    @Size(max = 100)
    @Column(length = 100)
    private String comment;

    @ManyToOne(targetEntity = Timesheet.class, fetch = FetchType.LAZY)
    @JoinColumn(name = "timesheet_id", nullable = false)
    private Timesheet timesheet;
}
