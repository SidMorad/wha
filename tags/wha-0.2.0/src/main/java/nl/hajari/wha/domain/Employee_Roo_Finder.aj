package nl.hajari.wha.domain;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.User;

privileged aspect Employee_Roo_Finder {
    
    public static Query Employee.findEmployeesByUser(User user) {    
        if (user == null) throw new IllegalArgumentException("The user argument is required");        
        EntityManager em = Employee.entityManager();        
        Query q = em.createQuery("SELECT Employee FROM Employee AS employee WHERE employee.user = :user");        
        q.setParameter("user", user);        
        return q;        
    }    
    
}
