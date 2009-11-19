package nl.hajari.wha.domain;

import javax.persistence.Entity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;
import javax.validation.constraints.Size;
import java.util.Date;
import javax.validation.constraints.NotNull;
import javax.persistence.Column;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import nl.hajari.wha.domain.DailyTimesheet;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import nl.hajari.wha.domain.Project;

@Entity
@RooJavaBean
@RooToString
@RooEntity
public class HourlyTimesheet {

    @Size(max = 45)
    @Column(name = "hourly_timesheetcol", length = 45)
    private String hourlyTimesheetcol;

    @NotNull
    @Temporal(TemporalType.TIME)
    private Date timeFrom;

    @NotNull
    @Temporal(TemporalType.TIME)
    private Date timeTo;

    @Temporal(TemporalType.DATE)
    private Date timeDate;

    private Float duration;

    private Float durationOffs;

    private Float durationTraining;

    @NotNull
    @ManyToOne(targetEntity = DailyTimesheet.class)
    @JoinColumn(name = "daily_timesheet_id")
    private DailyTimesheet dailyTimesheet;

    @ManyToOne(targetEntity = Project.class)
    @JoinColumn(name = "project_id")
    private Project project;
}
