package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect EmployeeConstants_Roo_ToString {
    
    public String EmployeeConstants.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Id: ").append(getId()).append(", ");
        sb.append("Version: ").append(getVersion()).append(", ");
        sb.append("Key: ").append(getKey()).append(", ");
        sb.append("Value: ").append(getValue()).append(", ");
        sb.append("Employee: ").append(getEmployee());
        return sb.toString();
    }
    
}
