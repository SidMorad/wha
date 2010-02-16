package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect BizLog_Roo_ToString {
    
    public String BizLog.toString() {    
        StringBuilder sb = new StringBuilder();        
        sb.append("Id: ").append(getId()).append(", ");        
        sb.append("Version: ").append(getVersion()).append(", ");        
        sb.append("Time: ").append(getTime()).append(", ");        
        sb.append("Details: ").append(getDetails()).append(", ");        
        sb.append("Username: ").append(getUsername()).append(", ");        
        sb.append("User: ").append(getUser()).append(", ");        
        sb.append("Employee: ").append(getEmployee()).append(", ");        
        sb.append("Timesheet: ").append(getTimesheet());        
        return sb.toString();        
    }    
    
}
