package nl.hajari.wha.domain;

import java.lang.String;
import java.lang.SuppressWarnings;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.User;

privileged aspect Employee_Roo_Finder {
    
    @SuppressWarnings("unchecked")
    public static Query Employee.findEmployeesByUser(User user) {
        if (user == null) throw new IllegalArgumentException("The user argument is required");
        EntityManager em = Employee.entityManager();
        Query q = em.createQuery("SELECT Employee FROM Employee AS employee WHERE employee.user = :user");
        q.setParameter("user", user);
        return q;
    }
    
    @SuppressWarnings("unchecked")
    public static Query Employee.findEmployeesByEmpId(String empId) {
        if (empId == null || empId.length() == 0) throw new IllegalArgumentException("The empId argument is required");
        EntityManager em = Employee.entityManager();
        Query q = em.createQuery("SELECT Employee FROM Employee AS employee WHERE employee.empId = :empId");
        q.setParameter("empId", empId);
        return q;
    }
    
    @SuppressWarnings("unchecked")
    public static Query Employee.findEmployeesByArchived(boolean archived) {
        EntityManager em = Employee.entityManager();
        Query q = em.createQuery("SELECT Employee FROM Employee AS employee WHERE employee.archived = :archived");
        q.setParameter("archived", archived);
        return q;
    }
    
}
