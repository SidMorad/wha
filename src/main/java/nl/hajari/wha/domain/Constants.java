package nl.hajari.wha.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.validation.constraints.NotNull;

import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.tostring.RooToString;
import org.springframework.roo.addon.entity.RooEntity;

@Entity
@RooJavaBean
@RooToString
@RooEntity
public class Constants {

	@NotNull
	@Column(name = "cons_key" , length = 30)
	private String key;
	
	@NotNull
	@Column(name = "cons_value", length = 50)
	private String value;
}
