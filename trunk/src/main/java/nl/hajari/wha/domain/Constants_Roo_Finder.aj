package nl.hajari.wha.domain;

import java.lang.String;
import javax.persistence.EntityManager;
import javax.persistence.Query;

privileged aspect Constants_Roo_Finder {
    
    public static Query Constants.findConstantsesByKeyEquals(String key) {    
        if (key == null || key.length() == 0) throw new IllegalArgumentException("The key argument is required");        
        EntityManager em = Constants.entityManager();        
        Query q = em.createQuery("SELECT Constants FROM Constants AS constants WHERE constants.key = :key");        
        q.setParameter("key", key);        
        return q;        
    }    
    
}
