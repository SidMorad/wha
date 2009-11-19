package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect Project_Roo_ToString {
    
    public String Project.toString() {    
        StringBuilder sb = new StringBuilder();        
        sb.append("Id: ").append(getId()).append(", ");        
        sb.append("Version: ").append(getVersion()).append(", ");        
        sb.append("Name: ").append(getName()).append(", ");        
        sb.append("Customer: ").append(getCustomer());        
        return sb.toString();        
    }    
    
}
