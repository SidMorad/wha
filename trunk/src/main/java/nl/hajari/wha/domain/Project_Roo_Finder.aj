package nl.hajari.wha.domain;

import java.lang.String;
import javax.persistence.EntityManager;
import javax.persistence.Query;

privileged aspect Project_Roo_Finder {
    
    public static Query Project.findProjectsByNameEquals(String name) {    
        if (name == null || name.length() == 0) throw new IllegalArgumentException("The name argument is required");        
        EntityManager em = Project.entityManager();        
        Query q = em.createQuery("SELECT Project FROM Project AS project WHERE project.name = :name");        
        q.setParameter("name", name);        
        return q;        
    }    
    
    public static Query Project.findProjectsByNameLike(String name) {    
        if (name == null || name.length() == 0) throw new IllegalArgumentException("The name argument is required");        
        name = name.replace('*', '%');        
        if (name.charAt(0) != '%') {        
            name = "%" + name;            
        }        
        if (name.charAt(name.length() -1) != '%') {        
            name = name + "%";            
        }        
        EntityManager em = Project.entityManager();        
        Query q = em.createQuery("SELECT Project FROM Project AS project WHERE project.name LIKE :name");        
        q.setParameter("name", name);        
        return q;        
    }    
    
}
