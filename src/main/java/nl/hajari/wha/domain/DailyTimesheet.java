package nl.hajari.wha.domain;

import java.util.Calendar;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import nl.hajari.wha.domain.enums.Month;
import nl.hajari.wha.domain.enums.WeekDay;
import nl.hajari.wha.web.validator.DayDateIsInCurrentMonth;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@RooEntity
@RooJavaBean
@DayDateIsInCurrentMonth
public class DailyTimesheet {

	@NotNull
	@Temporal(TemporalType.DATE)
	@Column(nullable=false)
	private Date dayDate;
		
	@NotNull
	@Column(nullable=false)
    private Float duration;

    private Float durationOffs;

    private Float durationTraining;
	
	private Float dailyTotalDuration;

//	@NotNull TODO: We need to figure it out how we cloud ignore this validation programmatically.  
	@ManyToOne(targetEntity = Timesheet.class)
	@JoinColumn(name = "timesheet_id", nullable=false)
	private Timesheet timesheet;

    @ManyToOne(targetEntity = Project.class)
    @JoinColumn(name = "project_id", nullable=false)
    private Project project;
	
	public String toString() {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dayDate);
		int weekdayInt = calendar.get(Calendar.DAY_OF_WEEK);
		int monthInt = calendar.get(Calendar.MONTH);
		int dayInt = calendar.get(Calendar.DAY_OF_MONTH);
		WeekDay weekDay = WeekDay.class.getEnumConstants()[weekdayInt-1];
		Month month = Month.class.getEnumConstants()[monthInt];
		
		return weekDay + " "+ month + " " + dayInt + " > " + duration;
	}
}
