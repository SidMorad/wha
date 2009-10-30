package nl.hajari.wha.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@RooJavaBean
@RooEntity
public class Employee {

    @NotNull
    @Size(min = 2, max = 30)
    private String firstname;

    @NotNull
    @Size(min = 2, max = 30)
    private String lastname;

    @Temporal(TemporalType.TIMESTAMP)
    private Date birthday;

    @Size(max = 30)
    private String email;

    @Override
    public String toString() {
    	return firstname + " " + lastname;
    }
}
