package nl.hajari.wha.domain;

import java.lang.Integer;
import java.lang.Long;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.EntityManager;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PersistenceContext;
import javax.persistence.Version;
import nl.hajari.wha.domain.Customer;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Customer_Roo_Entity {
    
    @PersistenceContext    
    transient EntityManager Customer.entityManager;    
    
    @Id    
    @GeneratedValue(strategy = GenerationType.AUTO)    
    @Column(name = "id")    
    private Long Customer.id;    
    
    @Version    
    @Column(name = "version")    
    private Integer Customer.version;    
    
    public Long Customer.getId() {    
        return this.id;        
    }    
    
    public void Customer.setId(Long id) {    
        this.id = id;        
    }    
    
    public Integer Customer.getVersion() {    
        return this.version;        
    }    
    
    public void Customer.setVersion(Integer version) {    
        this.version = version;        
    }    
    
    @Transactional    
    public void Customer.persist() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.persist(this);        
    }    
    
    @Transactional    
    public void Customer.remove() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        if (this.entityManager.contains(this)) {        
            this.entityManager.remove(this);            
        } else {        
            Customer attached = this.entityManager.find(Customer.class, this.id);            
            this.entityManager.remove(attached);            
        }        
    }    
    
    @Transactional    
    public void Customer.flush() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.flush();        
    }    
    
    @Transactional    
    public void Customer.merge() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        Customer merged = this.entityManager.merge(this);        
        this.entityManager.flush();        
        this.id = merged.getId();        
    }    
    
    public static final EntityManager Customer.entityManager() {    
        EntityManager em = new Customer().entityManager;        
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");        
        return em;        
    }    
    
    public static long Customer.countCustomers() {    
        return (Long) entityManager().createQuery("select count(o) from Customer o").getSingleResult();        
    }    
    
    public static List<Customer> Customer.findAllCustomers() {    
        return entityManager().createQuery("select o from Customer o").getResultList();        
    }    
    
    public static Customer Customer.findCustomer(Long id) {    
        if (id == null) throw new IllegalArgumentException("An identifier is required to retrieve an instance of Customer");        
        return entityManager().find(Customer.class, id);        
    }    
    
    public static List<Customer> Customer.findCustomerEntries(int firstResult, int maxResults) {    
        return entityManager().createQuery("select o from Customer o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();        
    }    
    
}
