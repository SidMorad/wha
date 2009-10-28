package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect Employee_Roo_ToString {
    
    public String Employee.toString() {    
        StringBuilder sb = new StringBuilder();        
        sb.append("Id: ").append(getId()).append(", ");        
        sb.append("Version: ").append(getVersion()).append(", ");        
        sb.append("Firstname: ").append(getFirstname()).append(", ");        
        sb.append("Lastname: ").append(getLastname()).append(", ");        
        sb.append("Birthday: ").append(getBirthday()).append(", ");        
        sb.append("Email: ").append(getEmail());        
        return sb.toString();        
    }    
    
}
