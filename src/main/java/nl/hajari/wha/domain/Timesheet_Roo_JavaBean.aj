package nl.hajari.wha.domain;

import java.lang.Float;
import java.lang.Integer;
import java.lang.String;
import java.util.Set;
import nl.hajari.wha.domain.DailyExpense;
import nl.hajari.wha.domain.DailyTimesheet;
import nl.hajari.wha.domain.DailyTravel;
import nl.hajari.wha.domain.Employee;

privileged aspect Timesheet_Roo_JavaBean {
    
    public Integer Timesheet.getSheetYear() {    
        return this.sheetYear;        
    }    
    
    public void Timesheet.setSheetYear(Integer sheetYear) {    
        this.sheetYear = sheetYear;        
    }    
    
    public Integer Timesheet.getSheetMonth() {    
        return this.sheetMonth;        
    }    
    
    public void Timesheet.setSheetMonth(Integer sheetMonth) {    
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
    
    public Set<DailyTravel> Timesheet.getDailyTravels() {    
        return this.dailyTravels;        
    }    
    
    public void Timesheet.setDailyTravels(Set<DailyTravel> dailyTravels) {    
        this.dailyTravels = dailyTravels;        
    }    
    
    public Set<DailyExpense> Timesheet.getDailyExpenses() {    
        return this.dailyExpenses;        
    }    
    
    public void Timesheet.setDailyExpenses(Set<DailyExpense> dailyExpenses) {    
        this.dailyExpenses = dailyExpenses;        
    }    
    
    public String Timesheet.getPoNumber() {    
        return this.poNumber;        
    }    
    
    public void Timesheet.setPoNumber(String poNumber) {    
        this.poNumber = poNumber;        
    }    
    
}
