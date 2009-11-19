package nl.hajari.wha.domain;

import java.lang.Float;
import java.lang.String;
import java.util.Date;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Project;

privileged aspect HourlyTimesheet_Roo_JavaBean {
    
    public String HourlyTimesheet.getHourlyTimesheetcol() {    
        return this.hourlyTimesheetcol;        
    }    
    
    public void HourlyTimesheet.setHourlyTimesheetcol(String hourlyTimesheetcol) {    
        this.hourlyTimesheetcol = hourlyTimesheetcol;        
    }    
    
    public Date HourlyTimesheet.getTimeFrom() {    
        return this.timeFrom;        
    }    
    
    public void HourlyTimesheet.setTimeFrom(Date timeFrom) {    
        this.timeFrom = timeFrom;        
    }    
    
    public Date HourlyTimesheet.getTimeTo() {    
        return this.timeTo;        
    }    
    
    public void HourlyTimesheet.setTimeTo(Date timeTo) {    
        this.timeTo = timeTo;        
    }    
    
    public Date HourlyTimesheet.getTimeDate() {    
        return this.timeDate;        
    }    
    
    public void HourlyTimesheet.setTimeDate(Date timeDate) {    
        this.timeDate = timeDate;        
    }    
    
    public Float HourlyTimesheet.getDuration() {    
        return this.duration;        
    }    
    
    public void HourlyTimesheet.setDuration(Float duration) {    
        this.duration = duration;        
    }    
    
    public Float HourlyTimesheet.getDurationOffs() {    
        return this.durationOffs;        
    }    
    
    public void HourlyTimesheet.setDurationOffs(Float durationOffs) {    
        this.durationOffs = durationOffs;        
    }    
    
    public Float HourlyTimesheet.getDurationTraining() {    
        return this.durationTraining;        
    }    
    
    public void HourlyTimesheet.setDurationTraining(Float durationTraining) {    
        this.durationTraining = durationTraining;        
    }    
    
    public DailyTimesheet HourlyTimesheet.getDailyTimesheet() {    
        return this.dailyTimesheet;        
    }    
    
    public void HourlyTimesheet.setDailyTimesheet(DailyTimesheet dailyTimesheet) {    
        this.dailyTimesheet = dailyTimesheet;        
    }    
    
    public Project HourlyTimesheet.getProject() {    
        return this.project;        
    }    
    
    public void HourlyTimesheet.setProject(Project project) {    
        this.project = project;        
    }    
    
}
