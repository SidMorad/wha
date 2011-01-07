package nl.hajari.wha.domain;

import java.lang.String;
import java.util.Date;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Timesheet;
import nl.hajari.wha.domain.User;

privileged aspect BizLog_Roo_JavaBean {
    
    public Date BizLog.getTime() {
        return this.time;
    }
    
    public void BizLog.setTime(Date time) {
        this.time = time;
    }
    
    public String BizLog.getDetails() {
        return this.details;
    }
    
    public void BizLog.setDetails(String details) {
        this.details = details;
    }
    
    public String BizLog.getUsername() {
        return this.username;
    }
    
    public void BizLog.setUsername(String username) {
        this.username = username;
    }
    
    public User BizLog.getUser() {
        return this.user;
    }
    
    public void BizLog.setUser(User user) {
        this.user = user;
    }
    
    public Employee BizLog.getEmployee() {
        return this.employee;
    }
    
    public void BizLog.setEmployee(Employee employee) {
        this.employee = employee;
    }
    
    public Timesheet BizLog.getTimesheet() {
        return this.timesheet;
    }
    
    public void BizLog.setTimesheet(Timesheet timesheet) {
        this.timesheet = timesheet;
    }
    
}
