package nl.hajari.wha.domain;

import java.lang.String;
import java.util.Date;

privileged aspect Employee_Roo_JavaBean {
    
    public String Employee.getFirstname() {    
        return this.firstname;        
    }    
    
    public void Employee.setFirstname(String firstname) {    
        this.firstname = firstname;        
    }    
    
    public String Employee.getLastname() {    
        return this.lastname;        
    }    
    
    public void Employee.setLastname(String lastname) {    
        this.lastname = lastname;        
    }    
    
    public Date Employee.getBirthday() {    
        return this.birthday;        
    }    
    
    public void Employee.setBirthday(Date birthday) {    
        this.birthday = birthday;        
    }    
    
    public String Employee.getEmail() {    
        return this.email;        
    }    
    
    public void Employee.setEmail(String email) {    
        this.email = email;        
    }    
    
}
