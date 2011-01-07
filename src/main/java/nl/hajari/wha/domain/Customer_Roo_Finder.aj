package nl.hajari.wha.domain;

import java.lang.String;
import java.lang.SuppressWarnings;
import javax.persistence.EntityManager;
import javax.persistence.Query;

privileged aspect Customer_Roo_Finder {
    
    @SuppressWarnings("unchecked")
    public static Query Customer.findCustomersByNameEquals(String name) {
        if (name == null || name.length() == 0) throw new IllegalArgumentException("The name argument is required");
        EntityManager em = Customer.entityManager();
        Query q = em.createQuery("SELECT Customer FROM Customer AS customer WHERE customer.name = :name");
        q.setParameter("name", name);
        return q;
    }
    
}
