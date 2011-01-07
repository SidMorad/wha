package nl.hajari.wha.domain;

import java.lang.String;
import java.lang.SuppressWarnings;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import nl.hajari.wha.domain.Customer;

privileged aspect Project_Roo_Finder {
    
    @SuppressWarnings("unchecked")
    public static Query Project.findProjectsByNameEquals(String name) {
        if (name == null || name.length() == 0) throw new IllegalArgumentException("The name argument is required");
        EntityManager em = Project.entityManager();
        Query q = em.createQuery("SELECT Project FROM Project AS project WHERE project.name = :name");
        q.setParameter("name", name);
        return q;
    }
    
    @SuppressWarnings("unchecked")
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
        Query q = em.createQuery("SELECT Project FROM Project AS project WHERE LOWER(project.name) LIKE LOWER(:name)");
        q.setParameter("name", name);
        return q;
    }
    
    @SuppressWarnings("unchecked")
    public static Query Project.findProjectsByCustomerAndNameEquals(Customer customer, String name) {
        if (customer == null) throw new IllegalArgumentException("The customer argument is required");
        if (name == null || name.length() == 0) throw new IllegalArgumentException("The name argument is required");
        EntityManager em = Project.entityManager();
        Query q = em.createQuery("SELECT Project FROM Project AS project WHERE project.customer = :customer AND project.name = :name");
        q.setParameter("customer", customer);
        q.setParameter("name", name);
        return q;
    }
    
}
