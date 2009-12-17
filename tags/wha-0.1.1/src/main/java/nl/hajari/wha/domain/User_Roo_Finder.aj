package nl.hajari.wha.domain;

import java.lang.String;
import javax.persistence.EntityManager;
import javax.persistence.Query;

privileged aspect User_Roo_Finder {
    
    public static Query User.findUsersByUsernameEquals(String username) {    
        if (username == null || username.length() == 0) throw new IllegalArgumentException("The username argument is required");        
        EntityManager em = User.entityManager();        
        Query q = em.createQuery("SELECT User FROM User AS user WHERE user.username = :username");        
        q.setParameter("username", username);        
        return q;        
    }    
    
}
