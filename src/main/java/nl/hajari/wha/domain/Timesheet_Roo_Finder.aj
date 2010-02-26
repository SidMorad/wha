package nl.hajari.wha.domain;

import java.lang.Integer;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.Employee;

privileged aspect Timesheet_Roo_Finder {
    
    public static Query Timesheet.findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals(Employee employee, Integer sheetMonth, Integer sheetYear) {    
        if (employee == null) throw new IllegalArgumentException("The employee argument is required");        
        if (sheetMonth == null) throw new IllegalArgumentException("The sheetMonth argument is required");        
        if (sheetYear == null) throw new IllegalArgumentException("The sheetYear argument is required");        
        EntityManager em = Timesheet.entityManager();        
        Query q = em.createQuery("SELECT Timesheet FROM Timesheet AS timesheet WHERE timesheet.employee = :employee AND timesheet.sheetMonth = :sheetMonth AND timesheet.sheetYear = :sheetYear");        
        q.setParameter("employee", employee);        
        q.setParameter("sheetMonth", sheetMonth);        
        q.setParameter("sheetYear", sheetYear);        
        return q;        
    }    
    
    public static Query Timesheet.findTimesheetsByEmployee(Employee employee) {    
        if (employee == null) throw new IllegalArgumentException("The employee argument is required");        
        EntityManager em = Timesheet.entityManager();        
        Query q = em.createQuery("SELECT Timesheet FROM Timesheet AS timesheet WHERE timesheet.employee = :employee");        
        q.setParameter("employee", employee);        
        return q;        
    }
    
    public static Query Timesheet.findAllTimesheetYears() {
    	EntityManager em = Timesheet.entityManager();
    	Query q = em.createQuery("SELECT DISTINCT t.sheetYear FROM Timesheet AS t");
    	return q;
    }
    
}
