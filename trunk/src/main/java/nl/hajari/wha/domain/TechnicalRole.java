package nl.hajari.wha.domain;

import java.math.BigDecimal;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@RooEntity
@RooJavaBean
public class TechnicalRole {

	@NotNull
	@Column(length = 30)
	private String name;
	
	private BigDecimal payRate;

	@Override
	public String toString() {
		return name + " pay rate: " + payRate ; 
	}
	
}
