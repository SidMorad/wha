package nl.hajari.wha.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@RooEntity
@RooJavaBean
public class DailyTimesheet {

	@NotNull
	@Temporal(TemporalType.DATE)
	private Date dayDate;


    private Float duration;

    private Float durationOffs;

    private Float durationTraining;
	
	private Float dailyTotalDuration;

	@NotNull
	@ManyToOne(targetEntity = Timesheet.class)
	@JoinColumn(name = "timesheet_id")
	private Timesheet timesheet;

    @ManyToOne(targetEntity = Project.class)
    @JoinColumn(name = "project_id")
    private Project project;
	
	public String toString() {
		return dayDate.getDate() + " " + dailyTotalDuration;
	}
}
