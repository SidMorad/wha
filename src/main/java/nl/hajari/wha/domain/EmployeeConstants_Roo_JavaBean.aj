package nl.hajari.wha.domain;

import java.lang.String;
import nl.hajari.wha.domain.Employee;

privileged aspect EmployeeConstants_Roo_JavaBean {
    
    public String EmployeeConstants.getKey() {
        return this.key;
    }
    
    public void EmployeeConstants.setKey(String key) {
        this.key = key;
    }
    
    public String EmployeeConstants.getValue() {
        return this.value;
    }
    
    public void EmployeeConstants.setValue(String value) {
        this.value = value;
    }
    
    public Employee EmployeeConstants.getEmployee() {
        return this.employee;
    }
    
    public void EmployeeConstants.setEmployee(Employee employee) {
        this.employee = employee;
    }
    
}
