package nl.hajari.wha.domain;

import java.lang.Float;
import java.lang.Integer;
import java.util.Set;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.enums.Month;

privileged aspect Timesheet_Roo_JavaBean {
    
    public Integer Timesheet.getSheetYear() {    
        return this.sheetYear;        
    }    
    
    public void Timesheet.setSheetYear(Integer sheetYear) {    
        this.sheetYear = sheetYear;        
    }    
    
    public Month Timesheet.getSheetMonth() {    
        return this.sheetMonth;        
    }    
    
    public void Timesheet.setSheetMonth(Month sheetMonth) {    
        this.sheetMonth = sheetMonth;        
    }    
    
    public Float Timesheet.getMonthlyTotal() {    
        return this.monthlyTotal;        
    }    
    
    public void Timesheet.setMonthlyTotal(Float monthlyTotal) {    
        this.monthlyTotal = monthlyTotal;        
    }    
    
    public Employee Timesheet.getEmployee() {    
        return this.employee;        
    }    
    
    public void Timesheet.setEmployee(Employee employee) {    
        this.employee = employee;        
    }    
    
    public Set<DailyTimesheet> Timesheet.getDailyTimesheets() {    
        return this.dailyTimesheets;        
    }    
    
    public void Timesheet.setDailyTimesheets(Set<DailyTimesheet> dailyTimesheets) {    
        this.dailyTimesheets = dailyTimesheets;        
    }    
    
}
