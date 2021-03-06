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
import nl.hajari.wha.domain.Employee;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Employee_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager Employee.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Employee.id;
    
    @Version
    @Column(name = "version")
    private Integer Employee.version;
    
    public Long Employee.getId() {
        return this.id;
    }
    
    public void Employee.setId(Long id) {
        this.id = id;
    }
    
    public Integer Employee.getVersion() {
        return this.version;
    }
    
    public void Employee.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Employee.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Employee.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Employee attached = this.entityManager.find(Employee.class, this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Employee.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Employee.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Employee merged = this.entityManager.merge(this);
        this.entityManager.flush();
        this.id = merged.getId();
    }
    
    public static final EntityManager Employee.entityManager() {
        EntityManager em = new Employee().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Employee.countEmployees() {
        return (Long) entityManager().createQuery("select count(o) from Employee o").getSingleResult();
    }
    
    public static List<Employee> Employee.findAllEmployees() {
        return entityManager().createQuery("select o from Employee o").getResultList();
    }
    
    public static Employee Employee.findEmployee(Long id) {
        if (id == null) return null;
        return entityManager().find(Employee.class, id);
    }
    
    public static List<Employee> Employee.findEmployeeEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from Employee o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
