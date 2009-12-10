package nl.hajari.wha.domain;

import java.lang.Float;
import java.util.Date;
import nl.hajari.wha.domain.Project;
import nl.hajari.wha.domain.Timesheet;

privileged aspect DailyTimesheet_Roo_JavaBean {
    
    public Date DailyTimesheet.getDayDate() {    
        return this.dayDate;        
    }    
    
    public void DailyTimesheet.setDayDate(Date dayDate) {    
        this.dayDate = dayDate;        
    }    
    
    public Float DailyTimesheet.getDuration() {    
        return this.duration;        
    }    
    
    public void DailyTimesheet.setDuration(Float duration) {    
        this.duration = duration;        
    }    
    
    public Float DailyTimesheet.getDurationOffs() {    
        return this.durationOffs;        
    }    
    
    public void DailyTimesheet.setDurationOffs(Float durationOffs) {    
        this.durationOffs = durationOffs;        
    }    
    
    public Float DailyTimesheet.getDurationTraining() {    
        return this.durationTraining;        
    }    
    
    public void DailyTimesheet.setDurationTraining(Float durationTraining) {    
        this.durationTraining = durationTraining;        
    }    
    
    public Float DailyTimesheet.getDailyTotalDuration() {    
        return this.dailyTotalDuration;        
    }    
    
    public void DailyTimesheet.setDailyTotalDuration(Float dailyTotalDuration) {    
        this.dailyTotalDuration = dailyTotalDuration;        
    }    
    
    public Timesheet DailyTimesheet.getTimesheet() {    
        return this.timesheet;        
    }    
    
    public void DailyTimesheet.setTimesheet(Timesheet timesheet) {    
        this.timesheet = timesheet;        
    }    
    
    public Project DailyTimesheet.getProject() {    
        return this.project;        
    }    
    
    public void DailyTimesheet.setProject(Project project) {    
        this.project = project;        
    }
    
    public void DailyTimesheet.setProjectName(String projectName) {
    	this.projectName = projectName;
    }
    
    public String DailyTimesheet.getProjectName() {
    	return this.projectName;
    }
    
}
