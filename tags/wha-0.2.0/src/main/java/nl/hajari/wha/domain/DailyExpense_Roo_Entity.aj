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
import nl.hajari.wha.domain.DailyExpense;
import org.springframework.transaction.annotation.Transactional;

privileged aspect DailyExpense_Roo_Entity {
    
    @PersistenceContext    
    transient EntityManager DailyExpense.entityManager;    
    
    @Id    
    @GeneratedValue(strategy = GenerationType.AUTO)    
    @Column(name = "id")    
    private Long DailyExpense.id;    
    
    @Version    
    @Column(name = "version")    
    private Integer DailyExpense.version;    
    
    public Long DailyExpense.getId() {    
        return this.id;        
    }    
    
    public void DailyExpense.setId(Long id) {    
        this.id = id;        
    }    
    
    public Integer DailyExpense.getVersion() {    
        return this.version;        
    }    
    
    public void DailyExpense.setVersion(Integer version) {    
        this.version = version;        
    }    
    
    @Transactional    
    public void DailyExpense.persist() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.persist(this);        
    }    
    
    @Transactional    
    public void DailyExpense.remove() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        if (this.entityManager.contains(this)) {        
            this.entityManager.remove(this);            
        } else {        
            DailyExpense attached = this.entityManager.find(DailyExpense.class, this.id);            
            this.entityManager.remove(attached);            
        }        
    }    
    
    @Transactional    
    public void DailyExpense.flush() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.flush();        
    }    
    
    @Transactional    
    public void DailyExpense.merge() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        DailyExpense merged = this.entityManager.merge(this);        
        this.entityManager.flush();        
        this.id = merged.getId();        
    }    
    
    public static final EntityManager DailyExpense.entityManager() {    
        EntityManager em = new DailyExpense().entityManager;        
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");        
        return em;        
    }    
    
    public static long DailyExpense.countDailyExpenses() {    
        return (Long) entityManager().createQuery("select count(o) from DailyExpense o").getSingleResult();        
    }    
    
    public static List<DailyExpense> DailyExpense.findAllDailyExpenses() {    
        return entityManager().createQuery("select o from DailyExpense o").getResultList();        
    }    
    
    public static DailyExpense DailyExpense.findDailyExpense(Long id) {    
        if (id == null) throw new IllegalArgumentException("An identifier is required to retrieve an instance of DailyExpense");        
        return entityManager().find(DailyExpense.class, id);        
    }    
    
    public static List<DailyExpense> DailyExpense.findDailyExpenseEntries(int firstResult, int maxResults) {    
        return entityManager().createQuery("select o from DailyExpense o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();        
    }    
    
}
