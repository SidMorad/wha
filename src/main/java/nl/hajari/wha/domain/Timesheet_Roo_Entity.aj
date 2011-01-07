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
import nl.hajari.wha.domain.Timesheet;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Timesheet_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager Timesheet.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Timesheet.id;
    
    @Version
    @Column(name = "version")
    private Integer Timesheet.version;
    
    public Long Timesheet.getId() {
        return this.id;
    }
    
    public void Timesheet.setId(Long id) {
        this.id = id;
    }
    
    public Integer Timesheet.getVersion() {
        return this.version;
    }
    
    public void Timesheet.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Timesheet.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Timesheet.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Timesheet attached = this.entityManager.find(Timesheet.class, this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Timesheet.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Timesheet.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Timesheet merged = this.entityManager.merge(this);
        this.entityManager.flush();
        this.id = merged.getId();
    }
    
    public static final EntityManager Timesheet.entityManager() {
        EntityManager em = new Timesheet().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Timesheet.countTimesheets() {
        return (Long) entityManager().createQuery("select count(o) from Timesheet o").getSingleResult();
    }
    
    public static List<Timesheet> Timesheet.findAllTimesheets() {
        return entityManager().createQuery("select o from Timesheet o").getResultList();
    }
    
    public static Timesheet Timesheet.findTimesheet(Long id) {
        if (id == null) return null;
        return entityManager().find(Timesheet.class, id);
    }
    
    public static List<Timesheet> Timesheet.findTimesheetEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from Timesheet o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
