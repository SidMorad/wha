package nl.hajari.wha.domain;

import java.lang.String;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.MonthStatus;

privileged aspect EmpMonth_Roo_JavaBean {
    
    public String EmpMonth.getNumber() {    
        return this.number;        
    }    
    
    public void EmpMonth.setNumber(String number) {    
        this.number = number;        
    }    
    
    public Employee EmpMonth.getEmployee() {    
        return this.employee;        
    }    
    
    public void EmpMonth.setEmployee(Employee employee) {    
        this.employee = employee;        
    }    
    
    public MonthStatus EmpMonth.getMonthStatus() {    
        return this.monthStatus;        
    }    
    
    public void EmpMonth.setMonthStatus(MonthStatus monthStatus) {    
        this.monthStatus = monthStatus;        
    }    
    
}
