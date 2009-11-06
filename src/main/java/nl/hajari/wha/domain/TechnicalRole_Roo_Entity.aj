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
import nl.hajari.wha.domain.TechnicalRole;
import org.springframework.transaction.annotation.Transactional;

privileged aspect TechnicalRole_Roo_Entity {
    
    @PersistenceContext    
    transient EntityManager TechnicalRole.entityManager;    
    
    @Id    
    @GeneratedValue(strategy = GenerationType.AUTO)    
    @Column(name = "id")    
    private Long TechnicalRole.id;    
    
    @Version    
    @Column(name = "version")    
    private Integer TechnicalRole.version;    
    
    public Long TechnicalRole.getId() {    
        return this.id;        
    }    
    
    public void TechnicalRole.setId(Long id) {    
        this.id = id;        
    }    
    
    public Integer TechnicalRole.getVersion() {    
        return this.version;        
    }    
    
    public void TechnicalRole.setVersion(Integer version) {    
        this.version = version;        
    }    
    
    @Transactional    
    public void TechnicalRole.persist() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.persist(this);        
    }    
    
    @Transactional    
    public void TechnicalRole.remove() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        if (this.entityManager.contains(this)) {        
            this.entityManager.remove(this);            
        } else {        
            TechnicalRole attached = this.entityManager.find(TechnicalRole.class, this.id);            
            this.entityManager.remove(attached);            
        }        
    }    
    
    @Transactional    
    public void TechnicalRole.flush() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.flush();        
    }    
    
    @Transactional    
    public void TechnicalRole.merge() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        TechnicalRole merged = this.entityManager.merge(this);        
        this.entityManager.flush();        
        this.id = merged.getId();        
    }    
    
    public static EntityManager TechnicalRole.entityManager() {    
        EntityManager em = new TechnicalRole().entityManager;        
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");        
        return em;        
    }    
    
    public static long TechnicalRole.countTechnicalRoles() {    
        return (Long) entityManager().createQuery("select count(o) from TechnicalRole o").getSingleResult();        
    }    
    
    public static List<TechnicalRole> TechnicalRole.findAllTechnicalRoles() {    
        return entityManager().createQuery("select o from TechnicalRole o").getResultList();        
    }    
    
    public static TechnicalRole TechnicalRole.findTechnicalRole(Long id) {    
        if (id == null) throw new IllegalArgumentException("An identifier is required to retrieve an instance of TechnicalRole");        
        return entityManager().find(TechnicalRole.class, id);        
    }    
    
    public static List<TechnicalRole> TechnicalRole.findTechnicalRoleEntries(int firstResult, int maxResults) {    
        return entityManager().createQuery("select o from TechnicalRole o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();        
    }    
    
}
