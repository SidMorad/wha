package nl.hajari.wha.domain;

import java.util.Date;
import nl.hajari.wha.domain.User;

privileged aspect Employee_Roo_JavaBean {
    
    public User Employee.getUser() {    
        return this.user;        
    }    
    
    public void Employee.setUser(User user) {    
        this.user = user;        
    }    
    
    public Date Employee.getBirthday() {    
        return this.birthday;        
    }    
    
    public void Employee.setBirthday(Date birthday) {    
        this.birthday = birthday;        
    }    
    
}
