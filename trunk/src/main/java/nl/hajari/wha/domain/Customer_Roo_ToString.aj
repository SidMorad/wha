package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect Customer_Roo_ToString {
    
    public String Customer.toString() {    
        StringBuilder sb = new StringBuilder();        
        sb.append("Id: ").append(getId()).append(", ");        
        sb.append("Version: ").append(getVersion()).append(", ");        
        sb.append("Name: ").append(getName());        
        return sb.toString();        
    }    
    
}
