package nl.hajari.wha.domain;

import java.lang.String;
import java.lang.SuppressWarnings;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.Employee;

privileged aspect EmployeeConstants_Roo_Finder {
    
    @SuppressWarnings("unchecked")
    public static Query EmployeeConstants.findEmployeeConstantsesByEmployee(Employee employee) {
        if (employee == null) throw new IllegalArgumentException("The employee argument is required");
        EntityManager em = EmployeeConstants.entityManager();
        Query q = em.createQuery("SELECT EmployeeConstants FROM EmployeeConstants AS employeeconstants WHERE employeeconstants.employee = :employee");
        q.setParameter("employee", employee);
        return q;
    }
    
    @SuppressWarnings("unchecked")
    public static Query EmployeeConstants.findEmployeeConstantsesByEmployeeAndKeyEquals(Employee employee, String key) {
        if (employee == null) throw new IllegalArgumentException("The employee argument is required");
        if (key == null || key.length() == 0) throw new IllegalArgumentException("The key argument is required");
        EntityManager em = EmployeeConstants.entityManager();
        Query q = em.createQuery("SELECT EmployeeConstants FROM EmployeeConstants AS employeeconstants WHERE employeeconstants.employee = :employee AND employeeconstants.key = :key");
        q.setParameter("employee", employee);
        q.setParameter("key", key);
        return q;
    }
    
}
