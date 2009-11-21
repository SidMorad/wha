package nl.hajari.wha.domain;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@RooJavaBean
@RooEntity
public class Customer {

    @NotNull
    @Size(max = 45)
    private String name;

    @Override
    public String toString() {
    	return name;
    }
}
