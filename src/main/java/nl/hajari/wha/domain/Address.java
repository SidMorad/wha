package nl.hajari.wha.domain;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import org.springframework.roo.addon.javabean.RooJavaBean;

@Embeddable
@RooJavaBean
public class Address {
	
	@Column(length = 100)
	private String address;
	
	@Column(length = 50)
	private String city;
	
	@Column(length = 50)
	private String province;
	
	@Column(length = 50)
	private String country;
	
	@Column(length = 15)
	private String postcode;

}
