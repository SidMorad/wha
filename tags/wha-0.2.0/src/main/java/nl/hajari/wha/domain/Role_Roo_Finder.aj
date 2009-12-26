package nl.hajari.wha.domain;

import java.lang.String;
import javax.persistence.EntityManager;
import javax.persistence.Query;

privileged aspect Role_Roo_Finder {
    
    public static Query Role.findRolesByNameEquals(String name) {    
        if (name == null || name.length() == 0) throw new IllegalArgumentException("The name argument is required");        
        EntityManager em = Role.entityManager();        
        Query q = em.createQuery("SELECT Role FROM Role AS role WHERE role.name = :name");        
        q.setParameter("name", name);        
        return q;        
    }    
    
}
