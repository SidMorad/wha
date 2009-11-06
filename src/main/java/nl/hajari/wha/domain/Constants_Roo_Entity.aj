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
import nl.hajari.wha.domain.Constants;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Constants_Roo_Entity {
    
    @PersistenceContext    
    transient EntityManager Constants.entityManager;    
    
    @Id    
    @GeneratedValue(strategy = GenerationType.AUTO)    
    @Column(name = "id")    
    private Long Constants.id;    
    
    @Version    
    @Column(name = "version")    
    private Integer Constants.version;    
    
    public Long Constants.getId() {    
        return this.id;        
    }    
    
    public void Constants.setId(Long id) {    
        this.id = id;        
    }    
    
    public Integer Constants.getVersion() {    
        return this.version;        
    }    
    
    public void Constants.setVersion(Integer version) {    
        this.version = version;        
    }    
    
    @Transactional    
    public void Constants.persist() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.persist(this);        
    }    
    
    @Transactional    
    public void Constants.remove() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        if (this.entityManager.contains(this)) {        
            this.entityManager.remove(this);            
        } else {        
            Constants attached = this.entityManager.find(Constants.class, this.id);            
            this.entityManager.remove(attached);            
        }        
    }    
    
    @Transactional    
    public void Constants.flush() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.flush();        
    }    
    
    @Transactional    
    public void Constants.merge() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        Constants merged = this.entityManager.merge(this);        
        this.entityManager.flush();        
        this.id = merged.getId();        
    }    
    
    public static EntityManager Constants.entityManager() {    
        EntityManager em = new Constants().entityManager;        
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");        
        return em;        
    }    
    
    public static long Constants.countConstantses() {    
        return (Long) entityManager().createQuery("select count(o) from Constants o").getSingleResult();        
    }    
    
    public static List<Constants> Constants.findAllConstantses() {    
        return entityManager().createQuery("select o from Constants o").getResultList();        
    }    
    
    public static Constants Constants.findConstants(Long id) {    
        if (id == null) throw new IllegalArgumentException("An identifier is required to retrieve an instance of Constants");        
        return entityManager().find(Constants.class, id);        
    }    
    
    public static List<Constants> Constants.findConstantsEntries(int firstResult, int maxResults) {    
        return entityManager().createQuery("select o from Constants o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();        
    }    
    
}
