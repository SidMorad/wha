package nl.hajari.wha.domain;

import java.lang.String;
import java.math.BigDecimal;
import nl.hajari.wha.domain.User;

privileged aspect Employee_Roo_JavaBean {
    
    public String Employee.getFirstName() {    
        return this.firstName;        
    }    
    
    public void Employee.setFirstName(String firstName) {    
        this.firstName = firstName;        
    }    
    
    public String Employee.getLastName() {    
        return this.lastName;        
    }    
    
    public void Employee.setLastName(String lastName) {    
        this.lastName = lastName;        
    }    
    
    public String Employee.getEmployeeId() {    
        return this.employeeId;        
    }    
    
    public void Employee.setEmployeeId(String employeeId) {    
        this.employeeId = employeeId;        
    }    
    
    public User Employee.getUser() {    
        return this.user;        
    }    
    
    public void Employee.setUser(User user) {    
        this.user = user;        
    }    
    
    public BigDecimal Employee.getPayRate() {    
        return this.payRate;        
    }    
    
    public void Employee.setPayRate(BigDecimal payRate) {    
        this.payRate = payRate;        
    }    
    
}
