package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect DailyExpense_Roo_ToString {
    
    public String DailyExpense.toString() {    
        StringBuilder sb = new StringBuilder();        
        sb.append("Id: ").append(getId()).append(", ");        
        sb.append("Version: ").append(getVersion()).append(", ");        
        sb.append("DayDate: ").append(getDayDate()).append(", ");        
        sb.append("ExpenseFor: ").append(getExpenseFor()).append(", ");        
        sb.append("ExpenseAmount: ").append(getExpenseAmount()).append(", ");        
        sb.append("ExpenseComment: ").append(getExpenseComment()).append(", ");        
        sb.append("Timesheet: ").append(getTimesheet());        
        return sb.toString();        
    }    
    
}
