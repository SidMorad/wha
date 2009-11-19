package nl.hajari.wha.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@RooEntity
@RooJavaBean
public class TechRole {

	@NotNull
	@Size(min = 1, max = 45)
	@Column(length = 45)
	private String name;

	private Float hourlyWage;

	public String toString() {
		return name + " " + hourlyWage;
	}

}
