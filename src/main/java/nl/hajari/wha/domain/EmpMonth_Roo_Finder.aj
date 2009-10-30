package nl.hajari.wha.domain;

import java.lang.String;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.Employee;

privileged aspect EmpMonth_Roo_Finder {
    
    public static Query EmpMonth.findEmpMonthsByNumberEquals(String number) {    
        if (number == null || number.length() == 0) throw new IllegalArgumentException("The number argument is required");        
        EntityManager em = EmpMonth.entityManager();        
        Query q = em.createQuery("SELECT EmpMonth FROM EmpMonth AS empmonth WHERE empmonth.number = :number");        
        q.setParameter("number", number);        
        return q;        
    }    
    
    public static Query EmpMonth.findEmpMonthsByEmployeeAndNumberEquals(Employee employee, String number) {    
        if (employee == null) throw new IllegalArgumentException("The employee argument is required");        
        if (number == null || number.length() == 0) throw new IllegalArgumentException("The number argument is required");        
        EntityManager em = EmpMonth.entityManager();        
        Query q = em.createQuery("SELECT EmpMonth FROM EmpMonth AS empmonth WHERE empmonth.employee = :employee AND empmonth.number = :number");        
        q.setParameter("employee", employee);        
        q.setParameter("number", number);        
        return q;        
    }    
    
}
