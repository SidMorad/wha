package nl.hajari.wha.domain;

import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import nl.hajari.wha.web.validator.DayDateIsInCurrentMonth;
import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@RooJavaBean
@DayDateIsInCurrentMonth
@RooEntity(finders = { "findDailyTimesheetsByTimesheet", "findDailyTimesheetsByDayDateAndTimesheet" })
public class DailyTimesheet {

    @NotNull
    @Temporal(TemporalType.DATE)
    @Column(nullable = false)
    private Date dayDate;

    @NotNull
    @Column(nullable = false)
    private Float duration;

    @NotNull
    private Float durationOffs;

    @NotNull
    private Float durationTraining;

    private Float dailyTotalDuration;

    @ManyToOne(targetEntity = Timesheet.class)
    @JoinColumn(name = "timesheet_id", nullable = false)
    private Timesheet timesheet;

    @ManyToOne(targetEntity = Project.class)
    @JoinColumn(name = "project_id", nullable = false)
    private Project project;

    public String toString() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(dayDate);
        int dayInt = calendar.get(Calendar.DAY_OF_MONTH);
        String weekDay = calendar.getDisplayName(Calendar.DAY_OF_WEEK, Calendar.LONG, Locale.getDefault());
        String month = calendar.getDisplayName(Calendar.MONTH, Calendar.SHORT, Locale.getDefault());
        return weekDay + " " + month + " " + dayInt + " > " + duration;
    }
}
