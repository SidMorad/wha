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
import nl.hajari.wha.domain.DailyTimesheet;
import org.springframework.transaction.annotation.Transactional;

privileged aspect DailyTimesheet_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager DailyTimesheet.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long DailyTimesheet.id;
    
    @Version
    @Column(name = "version")
    private Integer DailyTimesheet.version;
    
    public Long DailyTimesheet.getId() {
        return this.id;
    }
    
    public void DailyTimesheet.setId(Long id) {
        this.id = id;
    }
    
    public Integer DailyTimesheet.getVersion() {
        return this.version;
    }
    
    public void DailyTimesheet.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void DailyTimesheet.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void DailyTimesheet.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            DailyTimesheet attached = this.entityManager.find(DailyTimesheet.class, this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void DailyTimesheet.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void DailyTimesheet.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        DailyTimesheet merged = this.entityManager.merge(this);
        this.entityManager.flush();
        this.id = merged.getId();
    }
    
    public static final EntityManager DailyTimesheet.entityManager() {
        EntityManager em = new DailyTimesheet().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long DailyTimesheet.countDailyTimesheets() {
        return (Long) entityManager().createQuery("select count(o) from DailyTimesheet o").getSingleResult();
    }
    
    public static List<DailyTimesheet> DailyTimesheet.findAllDailyTimesheets() {
        return entityManager().createQuery("select o from DailyTimesheet o").getResultList();
    }
    
    public static DailyTimesheet DailyTimesheet.findDailyTimesheet(Long id) {
        if (id == null) return null;
        return entityManager().find(DailyTimesheet.class, id);
    }
    
    public static List<DailyTimesheet> DailyTimesheet.findDailyTimesheetEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from DailyTimesheet o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
