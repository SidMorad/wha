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
import nl.hajari.wha.domain.Project;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Project_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager Project.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Project.id;
    
    @Version
    @Column(name = "version")
    private Integer Project.version;
    
    public Long Project.getId() {
        return this.id;
    }
    
    public void Project.setId(Long id) {
        this.id = id;
    }
    
    public Integer Project.getVersion() {
        return this.version;
    }
    
    public void Project.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Project.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Project.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Project attached = this.entityManager.find(Project.class, this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Project.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Project.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Project merged = this.entityManager.merge(this);
        this.entityManager.flush();
        this.id = merged.getId();
    }
    
    public static final EntityManager Project.entityManager() {
        EntityManager em = new Project().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Project.countProjects() {
        return (Long) entityManager().createQuery("select count(o) from Project o").getSingleResult();
    }
    
    public static List<Project> Project.findAllProjects() {
        return entityManager().createQuery("select o from Project o").getResultList();
    }
    
    public static Project Project.findProject(Long id) {
        if (id == null) return null;
        return entityManager().find(Project.class, id);
    }
    
    public static List<Project> Project.findProjectEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from Project o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
