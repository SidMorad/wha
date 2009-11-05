package nl.hajari.wha.domain;

import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;
import nl.hajari.wha.domain.User;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;

@Entity
@RooJavaBean
@RooEntity
public class Employee {

	@ManyToOne(targetEntity = User.class)
	@JoinColumn
	private User user;

	@Temporal(TemporalType.TIMESTAMP)
    private Date birthday;

    @Override
    public String toString() {
        return "";
    }
}
