package nl.hajari.wha.domain;

import java.lang.Float;
import java.lang.String;
import java.util.Set;
import nl.hajari.wha.domain.TechRole;
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
    
    public String Employee.getEmpId() {    
        return this.empId;        
    }    
    
    public void Employee.setEmpId(String empId) {    
        this.empId = empId;        
    }    
    
    public Float Employee.getHourlyWage() {    
        return this.hourlyWage;        
    }    
    
    public void Employee.setHourlyWage(Float hourlyWage) {    
        this.hourlyWage = hourlyWage;        
    }    
    
    public User Employee.getUser() {    
        return this.user;        
    }    
    
    public void Employee.setUser(User user) {    
        this.user = user;        
    }    
    
    public Set<TechRole> Employee.getTechRoles() {    
        return this.techRoles;        
    }    
    
    public void Employee.setTechRoles(Set<TechRole> techRoles) {    
        this.techRoles = techRoles;        
    }    
    
}
