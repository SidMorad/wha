package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect DailyTravel_Roo_ToString {
    
    public String DailyTravel.toString() {    
        StringBuilder sb = new StringBuilder();        
        sb.append("Id: ").append(getId()).append(", ");        
        sb.append("Version: ").append(getVersion()).append(", ");        
        sb.append("DayDate: ").append(getDayDate()).append(", ");        
        sb.append("Origin: ").append(getOrigin()).append(", ");        
        sb.append("Destination: ").append(getDestination()).append(", ");        
        sb.append("WithReturn: ").append(getWithReturn()).append(", ");        
        sb.append("Distance: ").append(getDistance()).append(", ");        
        sb.append("Comment: ").append(getComment()).append(", ");        
        sb.append("Timesheet: ").append(getTimesheet());        
        return sb.toString();        
    }    
    
}
