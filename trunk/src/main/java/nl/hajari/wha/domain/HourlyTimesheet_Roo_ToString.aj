package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect HourlyTimesheet_Roo_ToString {
    
    public String HourlyTimesheet.toString() {    
        StringBuilder sb = new StringBuilder();        
        sb.append("Id: ").append(getId()).append(", ");        
        sb.append("Version: ").append(getVersion()).append(", ");        
        sb.append("HourlyTimesheetcol: ").append(getHourlyTimesheetcol()).append(", ");        
        sb.append("TimeFrom: ").append(getTimeFrom()).append(", ");        
        sb.append("TimeTo: ").append(getTimeTo()).append(", ");        
        sb.append("TimeDate: ").append(getTimeDate()).append(", ");        
        sb.append("Duration: ").append(getDuration()).append(", ");        
        sb.append("DurationOffs: ").append(getDurationOffs()).append(", ");        
        sb.append("DurationTraining: ").append(getDurationTraining()).append(", ");        
        sb.append("DailyTimesheet: ").append(getDailyTimesheet()).append(", ");        
        sb.append("Project: ").append(getProject());        
        return sb.toString();        
    }    
    
}
