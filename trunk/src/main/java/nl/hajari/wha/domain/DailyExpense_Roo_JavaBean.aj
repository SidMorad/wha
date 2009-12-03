package nl.hajari.wha.domain;

import java.lang.Float;
import java.lang.String;
import java.util.Date;
import nl.hajari.wha.domain.Timesheet;

privileged aspect DailyExpense_Roo_JavaBean {
    
    public Date DailyExpense.getDayDate() {    
        return this.dayDate;        
    }    
    
    public void DailyExpense.setDayDate(Date dayDate) {    
        this.dayDate = dayDate;        
    }    
    
    public String DailyExpense.getExpenseFor() {    
        return this.expenseFor;        
    }    
    
    public void DailyExpense.setExpenseFor(String expenseFor) {    
        this.expenseFor = expenseFor;        
    }    
    
    public Float DailyExpense.getExpenseAmount() {    
        return this.expenseAmount;        
    }    
    
    public void DailyExpense.setExpenseAmount(Float expenseAmount) {    
        this.expenseAmount = expenseAmount;        
    }    
    
    public String DailyExpense.getExpenseComment() {    
        return this.expenseComment;        
    }    
    
    public void DailyExpense.setExpenseComment(String expenseComment) {    
        this.expenseComment = expenseComment;        
    }    
    
    public Timesheet DailyExpense.getTimesheet() {    
        return this.timesheet;        
    }    
    
    public void DailyExpense.setTimesheet(Timesheet timesheet) {    
        this.timesheet = timesheet;        
    }    
    
}
