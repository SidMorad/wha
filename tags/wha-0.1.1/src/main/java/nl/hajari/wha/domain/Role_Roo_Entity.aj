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
import nl.hajari.wha.domain.Role;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Role_Roo_Entity {
    
    @PersistenceContext    
    transient EntityManager Role.entityManager;    
    
    @Id    
    @GeneratedValue(strategy = GenerationType.AUTO)    
    @Column(name = "id")    
    private Long Role.id;    
    
    @Version    
    @Column(name = "version")    
    private Integer Role.version;    
    
    public Long Role.getId() {    
        return this.id;        
    }    
    
    public void Role.setId(Long id) {    
        this.id = id;        
    }    
    
    public Integer Role.getVersion() {    
        return this.version;        
    }    
    
    public void Role.setVersion(Integer version) {    
        this.version = version;        
    }    
    
    @Transactional    
    public void Role.persist() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.persist(this);        
    }    
    
    @Transactional    
    public void Role.remove() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        if (this.entityManager.contains(this)) {        
            this.entityManager.remove(this);            
        } else {        
            Role attached = this.entityManager.find(Role.class, this.id);            
            this.entityManager.remove(attached);            
        }        
    }    
    
    @Transactional    
    public void Role.flush() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        this.entityManager.flush();        
    }    
    
    @Transactional    
    public void Role.merge() {    
        if (this.entityManager == null) this.entityManager = entityManager();        
        Role merged = this.entityManager.merge(this);        
        this.entityManager.flush();        
        this.id = merged.getId();        
    }    
    
    public static final EntityManager Role.entityManager() {    
        EntityManager em = new Role().entityManager;        
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");        
        return em;        
    }    
    
    public static long Role.countRoles() {    
        return (Long) entityManager().createQuery("select count(o) from Role o").getSingleResult();        
    }    
    
    public static List<Role> Role.findAllRoles() {    
        return entityManager().createQuery("select o from Role o").getResultList();        
    }    
    
    public static Role Role.findRole(Long id) {    
        if (id == null) throw new IllegalArgumentException("An identifier is required to retrieve an instance of Role");        
        return entityManager().find(Role.class, id);        
    }    
    
    public static List<Role> Role.findRoleEntries(int firstResult, int maxResults) {    
        return entityManager().createQuery("select o from Role o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();        
    }    
    
}
