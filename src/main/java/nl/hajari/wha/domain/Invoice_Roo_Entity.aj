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
import nl.hajari.wha.domain.Invoice;
import org.springframework.transaction.annotation.Transactional;

privileged aspect Invoice_Roo_Entity {
    
    @PersistenceContext
    transient EntityManager Invoice.entityManager;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Invoice.id;
    
    @Version
    @Column(name = "version")
    private Integer Invoice.version;
    
    public Long Invoice.getId() {
        return this.id;
    }
    
    public void Invoice.setId(Long id) {
        this.id = id;
    }
    
    public Integer Invoice.getVersion() {
        return this.version;
    }
    
    public void Invoice.setVersion(Integer version) {
        this.version = version;
    }
    
    @Transactional
    public void Invoice.persist() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.persist(this);
    }
    
    @Transactional
    public void Invoice.remove() {
        if (this.entityManager == null) this.entityManager = entityManager();
        if (this.entityManager.contains(this)) {
            this.entityManager.remove(this);
        } else {
            Invoice attached = this.entityManager.find(Invoice.class, this.id);
            this.entityManager.remove(attached);
        }
    }
    
    @Transactional
    public void Invoice.flush() {
        if (this.entityManager == null) this.entityManager = entityManager();
        this.entityManager.flush();
    }
    
    @Transactional
    public void Invoice.merge() {
        if (this.entityManager == null) this.entityManager = entityManager();
        Invoice merged = this.entityManager.merge(this);
        this.entityManager.flush();
        this.id = merged.getId();
    }
    
    public static final EntityManager Invoice.entityManager() {
        EntityManager em = new Invoice().entityManager;
        if (em == null) throw new IllegalStateException("Entity manager has not been injected (is the Spring Aspects JAR configured as an AJC/AJDT aspects library?)");
        return em;
    }
    
    public static long Invoice.countInvoices() {
        return (Long) entityManager().createQuery("select count(o) from Invoice o").getSingleResult();
    }
    
    public static List<Invoice> Invoice.findAllInvoices() {
        return entityManager().createQuery("select o from Invoice o").getResultList();
    }
    
    public static Invoice Invoice.findInvoice(Long id) {
        if (id == null) return null;
        return entityManager().find(Invoice.class, id);
    }
    
    public static List<Invoice> Invoice.findInvoiceEntries(int firstResult, int maxResults) {
        return entityManager().createQuery("select o from Invoice o").setFirstResult(firstResult).setMaxResults(maxResults).getResultList();
    }
    
}
