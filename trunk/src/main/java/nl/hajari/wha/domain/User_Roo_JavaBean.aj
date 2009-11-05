package nl.hajari.wha.domain;

import java.lang.String;
import java.util.Set;
import nl.hajari.wha.domain.Role;

privileged aspect User_Roo_JavaBean {
    
    public void User.setUsername(String username) {    
        this.username = username;        
    }    
    
    public void User.setPassword(String password) {    
        this.password = password;        
    }    
    
    public String User.getFirstName() {    
        return this.firstName;        
    }    
    
    public void User.setFirstName(String firstName) {    
        this.firstName = firstName;        
    }    
    
    public String User.getLastName() {    
        return this.lastName;        
    }    
    
    public void User.setLastName(String lastName) {    
        this.lastName = lastName;        
    }    
    
    public String User.getEmail() {    
        return this.email;        
    }    
    
    public void User.setEmail(String email) {    
        this.email = email;        
    }    
    
    public String User.getPhone() {    
        return this.phone;        
    }    
    
    public void User.setPhone(String phone) {    
        this.phone = phone;        
    }    
    
    public Set<Role> User.getRoles() {    
        return this.roles;        
    }    
    
    public void User.setRoles(Set<Role> roles) {    
        this.roles = roles;        
    }    
    
    public void User.setEnabled(boolean enabled) {    
        this.enabled = enabled;        
    }    
    
    public boolean User.isAccountExpired() {    
        return this.accountExpired;        
    }    
    
    public void User.setAccountExpired(boolean accountExpired) {    
        this.accountExpired = accountExpired;        
    }    
    
    public boolean User.isAccountLocked() {    
        return this.accountLocked;        
    }    
    
    public void User.setAccountLocked(boolean accountLocked) {    
        this.accountLocked = accountLocked;        
    }    
    
    public boolean User.isCredentialsExpired() {    
        return this.credentialsExpired;        
    }    
    
    public void User.setCredentialsExpired(boolean credentialsExpired) {    
        this.credentialsExpired = credentialsExpired;        
    }    
    
}
