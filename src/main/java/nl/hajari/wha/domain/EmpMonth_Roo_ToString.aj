package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect EmpMonth_Roo_ToString {
    
    public String EmpMonth.toString() {    
        StringBuilder sb = new StringBuilder();        
        sb.append("Id: ").append(getId()).append(", ");        
        sb.append("Version: ").append(getVersion()).append(", ");        
        sb.append("Number: ").append(getNumber()).append(", ");        
        sb.append("Employee: ").append(getEmployee()).append(", ");        
        sb.append("MonthStatus: ").append(getMonthStatus());        
        return sb.toString();        
    }    
    
}
