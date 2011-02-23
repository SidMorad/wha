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
import nl.hajari.wha.domain.EmployeeConstants;
import org.springframework.transaction.annotation.Transactional;

privileged aspect EmployeeConstants_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager EmployeeConstants.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long EmployeeConstants.id;
    
    @Version
    @Column(name = "version")
    private Integer EmployeeConstants.version;
    
    public Long EmployeeConstants.getId() {
        return this.id;
    }
    
    public void EmployeeConstants.setId(Long id) {
        this.id = id;
    }
    
    public Integer EmployeeConstants.getVersion() {
        return this.version;
    }
    
    public void EmployeeConstants.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void EmployeeConstants.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void EmployeeConstants.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            EmployeeConstants attached = this.entityManager.find(EmployeeConstants.class, this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void EmployeeConstants.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void EmployeeConstants.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        EmployeeConstants merged = this.entityManager.merge(this);
        this.entityManager.flush();
        this.id = merged.getId();
    }
    
    public static final EntityManager EmployeeConstants.entityManager() {
        EntityManager em = new EmployeeConstants().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long EmployeeConstants.countEmployeeConstantses() {
        return (Long) entityManager().createQuery("select count(o) from EmployeeConstants o").getSingleResult();
    }
    
    public static List<EmployeeConstants> EmployeeConstants.findAllEmployeeConstantses() {
        return entityManager().createQuery("select o from EmployeeConstants o").getResultList();
    }
    
    public static EmployeeConstants EmployeeConstants.findEmployeeConstants(Long id) {
        if (id == null) return null;
        return entityManager().find(EmployeeConstants.class, id);
    }
    
    public static List<EmployeeConstants> EmployeeConstants.findEmployeeConstantsEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from EmployeeConstants o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
