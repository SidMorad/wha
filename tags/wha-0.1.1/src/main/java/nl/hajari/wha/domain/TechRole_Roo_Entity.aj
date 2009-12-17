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
import nl.hajari.wha.domain.TechRole;
import org.springframework.transaction.annotation.Transactional;

privileged aspect TechRole_Roo_Entity {
    
    @PersistenceContext    
    transient EntityManager TechRole.entityManager;    
    
    @Id    
    @GeneratedValue(strategy = GenerationType.AUTO)    
    @Column(name = "id")    
    private Long TechRole.id;    
    
    @Version    
    @Column(name = "version")    
    private Integer TechRole.version;    
    
    public Long TechRole.getId() {    
        return this.id;        
    }    
    
    public void TechRole.setId(Long id) {    
        this.id = id;        
    }    
    
    public Integer TechRole.getVersion() {    
        return this.version;        
    }    
    
    public void TechRole.setVersion(Integer version) {    
        this.version = version;        
    }    
    
    @Transactional    
    public void TechRole.persist() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.persist(this);        
    }    
    
    @Transactional    
    public void TechRole.remove() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        if (this.entityManager.contains(this)) {        
            this.entityManager.remove(this);            
        } else {        
            TechRole attached = this.entityManager.find(TechRole.class, this.id);            
            this.entityManager.remove(attached);            
        }        
    }    
    
    @Transactional    
    public void TechRole.flush() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.flush();        
    }    
    
    @Transactional    
    public void TechRole.merge() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        TechRole merged = this.entityManager.merge(this);        
        this.entityManager.flush();        
        this.id = merged.getId();        
    }    
    
    public static final EntityManager TechRole.entityManager() {    
        EntityManager em = new TechRole().entityManager;        
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");        
        return em;        
    }    
    
    public static long TechRole.countTechRoles() {    
        return (Long) entityManager().createQuery("select count(o) from TechRole o").getSingleResult();        
    }    
    
    public static List<TechRole> TechRole.findAllTechRoles() {    
        return entityManager().createQuery("select o from TechRole o").getResultList();        
    }    
    
    public static TechRole TechRole.findTechRole(Long id) {    
        if (id == null) throw new IllegalArgumentException("An identifier is required to retrieve an instance of TechRole");        
        return entityManager().find(TechRole.class, id);        
    }    
    
    public static List<TechRole> TechRole.findTechRoleEntries(int firstResult, int maxResults) {    
        return entityManager().createQuery("select o from TechRole o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();        
    }    
    
}
