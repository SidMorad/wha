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
import nl.hajari.wha.domain.DailyTravel;
import org.springframework.transaction.annotation.Transactional;

privileged aspect DailyTravel_Roo_Entity {
    
    @PersistenceContext    
    transient EntityManager DailyTravel.entityManager;    
    
    @Id    
    @GeneratedValue(strategy = GenerationType.AUTO)    
    @Column(name = "id")    
    private Long DailyTravel.id;    
    
    @Version    
    @Column(name = "version")    
    private Integer DailyTravel.version;    
    
    public Long DailyTravel.getId() {    
        return this.id;        
    }    
    
    public void DailyTravel.setId(Long id) {    
        this.id = id;        
    }    
    
    public Integer DailyTravel.getVersion() {    
        return this.version;        
    }    
    
    public void DailyTravel.setVersion(Integer version) {    
        this.version = version;        
    }    
    
    @Transactional    
    public void DailyTravel.persist() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.persist(this);        
    }    
    
    @Transactional    
    public void DailyTravel.remove() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        if (this.entityManager.contains(this)) {        
            this.entityManager.remove(this);            
        } else {        
            DailyTravel attached = this.entityManager.find(DailyTravel.class, this.id);            
            this.entityManager.remove(attached);            
        }        
    }    
    
    @Transactional    
    public void DailyTravel.flush() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.flush();        
    }    
    
    @Transactional    
    public void DailyTravel.merge() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        DailyTravel merged = this.entityManager.merge(this);        
        this.entityManager.flush();        
        this.id = merged.getId();        
    }    
    
    public static final EntityManager DailyTravel.entityManager() {    
        EntityManager em = new DailyTravel().entityManager;        
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");        
        return em;        
    }    
    
    public static long DailyTravel.countDailyTravels() {    
        return (Long) entityManager().createQuery("select count(o) from DailyTravel o").getSingleResult();        
    }    
    
    public static List<DailyTravel> DailyTravel.findAllDailyTravels() {    
        return entityManager().createQuery("select o from DailyTravel o").getResultList();        
    }    
    
    public static DailyTravel DailyTravel.findDailyTravel(Long id) {    
        if (id == null) throw new IllegalArgumentException("An identifier is required to retrieve an instance of DailyTravel");        
        return entityManager().find(DailyTravel.class, id);        
    }    
    
    public static List<DailyTravel> DailyTravel.findDailyTravelEntries(int firstResult, int maxResults) {    
        return entityManager().createQuery("select o from DailyTravel o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();        
    }    
    
}
