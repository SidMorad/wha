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
import nl.hajari.wha.domain.HourlyTimesheet;
import org.springframework.transaction.annotation.Transactional;

privileged aspect HourlyTimesheet_Roo_Entity {
    
    @PersistenceContext    
    transient EntityManager HourlyTimesheet.entityManager;    
    
    @Id    
    @GeneratedValue(strategy = GenerationType.AUTO)    
    @Column(name = "id")    
    private Long HourlyTimesheet.id;    
    
    @Version    
    @Column(name = "version")    
    private Integer HourlyTimesheet.version;    
    
    public Long HourlyTimesheet.getId() {    
        return this.id;        
    }    
    
    public void HourlyTimesheet.setId(Long id) {    
        this.id = id;        
    }    
    
    public Integer HourlyTimesheet.getVersion() {    
        return this.version;        
    }    
    
    public void HourlyTimesheet.setVersion(Integer version) {    
        this.version = version;        
    }    
    
    @Transactional    
    public void HourlyTimesheet.persist() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.persist(this);        
    }    
    
    @Transactional    
    public void HourlyTimesheet.remove() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        if (this.entityManager.contains(this)) {        
            this.entityManager.remove(this);            
        } else {        
            HourlyTimesheet attached = this.entityManager.find(HourlyTimesheet.class, this.id);            
            this.entityManager.remove(attached);            
        }        
    }    
    
    @Transactional    
    public void HourlyTimesheet.flush() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.flush();        
    }    
    
    @Transactional    
    public void HourlyTimesheet.merge() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        HourlyTimesheet merged = this.entityManager.merge(this);        
        this.entityManager.flush();        
        this.id = merged.getId();        
    }    
    
    public static final EntityManager HourlyTimesheet.entityManager() {    
        EntityManager em = new HourlyTimesheet().entityManager;        
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");        
        return em;        
    }    
    
    public static long HourlyTimesheet.countHourlyTimesheets() {    
        return (Long) entityManager().createQuery("select count(o) from HourlyTimesheet o").getSingleResult();        
    }    
    
    public static List<HourlyTimesheet> HourlyTimesheet.findAllHourlyTimesheets() {    
        return entityManager().createQuery("select o from HourlyTimesheet o").getResultList();        
    }    
    
    public static HourlyTimesheet HourlyTimesheet.findHourlyTimesheet(Long id) {    
        if (id == null) throw new IllegalArgumentException("An identifier is required to retrieve an instance of HourlyTimesheet");        
        return entityManager().find(HourlyTimesheet.class, id);        
    }    
    
    public static List<HourlyTimesheet> HourlyTimesheet.findHourlyTimesheetEntries(int firstResult, int maxResults) {    
        return entityManager().createQuery("select o from HourlyTimesheet o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();        
    }    
    
}
