package nl.hajari.wha.domain;

import java.lang.Float;
import java.util.Date;
import nl.hajari.wha.domain.Timesheet;

privileged aspect DailyTimesheet_Roo_JavaBean {
    
    public Date DailyTimesheet.getDayDate() {    
        return this.dayDate;        
    }    
    
    public void DailyTimesheet.setDayDate(Date dayDate) {    
        this.dayDate = dayDate;        
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
    
}
