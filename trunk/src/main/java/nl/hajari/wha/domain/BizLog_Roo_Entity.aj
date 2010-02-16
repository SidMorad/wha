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
import nl.hajari.wha.domain.BizLog;
import org.springframework.transaction.annotation.Transactional;

privileged aspect BizLog_Roo_Entity {
    
    @PersistenceContext    
    transient EntityManager BizLog.entityManager;    
    
    @Id    
    @GeneratedValue(strategy = GenerationType.AUTO)    
    @Column(name = "id")    
    private Long BizLog.id;    
    
    @Version    
    @Column(name = "version")    
    private Integer BizLog.version;    
    
    public Long BizLog.getId() {    
        return this.id;        
    }    
    
    public void BizLog.setId(Long id) {    
        this.id = id;        
    }    
    
    public Integer BizLog.getVersion() {    
        return this.version;        
    }    
    
    public void BizLog.setVersion(Integer version) {    
        this.version = version;        
    }    
    
    @Transactional    
    public void BizLog.persist() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.persist(this);        
    }    
    
    @Transactional    
    public void BizLog.remove() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        if (this.entityManager.contains(this)) {        
            this.entityManager.remove(this);            
        } else {        
            BizLog attached = this.entityManager.find(BizLog.class, this.id);            
            this.entityManager.remove(attached);            
        }        
    }    
    
    @Transactional    
    public void BizLog.flush() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.flush();        
    }    
    
    @Transactional    
    public void BizLog.merge() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        BizLog merged = this.entityManager.merge(this);        
        this.entityManager.flush();        
        this.id = merged.getId();        
    }    
    
    public static final EntityManager BizLog.entityManager() {    
        EntityManager em = new BizLog().entityManager;        
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");        
        return em;        
    }    
    
    public static long BizLog.countBizLogs() {    
        return (Long) entityManager().createQuery("select count(o) from BizLog o").getSingleResult();        
    }    
    
    public static List<BizLog> BizLog.findAllBizLogs() {    
        return entityManager().createQuery("select o from BizLog o").getResultList();        
    }    
    
    public static BizLog BizLog.findBizLog(Long id) {    
        if (id == null) throw new IllegalArgumentException("An identifier is required to retrieve an instance of BizLog");        
        return entityManager().find(BizLog.class, id);        
    }    
    
    public static List<BizLog> BizLog.findBizLogEntries(int firstResult, int maxResults) {    
        return entityManager().createQuery("select o from BizLog o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();        
    }    
    
}
