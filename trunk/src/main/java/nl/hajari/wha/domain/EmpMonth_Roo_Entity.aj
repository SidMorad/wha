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
import nl.hajari.wha.domain.EmpMonth;
import org.springframework.transaction.annotation.Transactional;

privileged aspect EmpMonth_Roo_Entity {
    
    @PersistenceContext    
    transient EntityManager EmpMonth.entityManager;    
    
    @Id    
    @GeneratedValue(strategy = GenerationType.AUTO)    
    @Column(name = "id")    
    private Long EmpMonth.id;    
    
    @Version    
    @Column(name = "version")    
    private Integer EmpMonth.version;    
    
    public Long EmpMonth.getId() {    
        return this.id;        
    }    
    
    public void EmpMonth.setId(Long id) {    
        this.id = id;        
    }    
    
    public Integer EmpMonth.getVersion() {    
        return this.version;        
    }    
    
    public void EmpMonth.setVersion(Integer version) {    
        this.version = version;        
    }    
    
    @Transactional    
    public void EmpMonth.persist() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.persist(this);        
    }    
    
    @Transactional    
    public void EmpMonth.remove() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        if (this.entityManager.contains(this)) {        
            this.entityManager.remove(this);            
        } else {        
            EmpMonth attached = this.entityManager.find(EmpMonth.class, this.id);            
            this.entityManager.remove(attached);            
        }        
    }    
    
    @Transactional    
    public void EmpMonth.flush() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.flush();        
    }    
    
    @Transactional    
    public void EmpMonth.merge() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        EmpMonth merged = this.entityManager.merge(this);        
        this.entityManager.flush();        
        this.id = merged.getId();        
    }    
    
    public static EntityManager EmpMonth.entityManager() {    
        EntityManager em = new EmpMonth().entityManager;        
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");        
        return em;        
    }    
    
    public static long EmpMonth.countEmpMonths() {    
        return (Long) entityManager().createQuery("select count(o) from EmpMonth o").getSingleResult();        
    }    
    
    public static List<EmpMonth> EmpMonth.findAllEmpMonths() {    
        return entityManager().createQuery("select o from EmpMonth o").getResultList();        
    }    
    
    public static EmpMonth EmpMonth.findEmpMonth(Long id) {    
        if (id == null) throw new IllegalArgumentException("An identifier is required to retrieve an instance of EmpMonth");        
        return entityManager().find(EmpMonth.class, id);        
    }    
    
    public static List<EmpMonth> EmpMonth.findEmpMonthEntries(int firstResult, int maxResults) {    
        return entityManager().createQuery("select o from EmpMonth o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();        
    }    
    
}
