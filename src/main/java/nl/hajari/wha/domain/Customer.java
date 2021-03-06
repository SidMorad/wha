package nl.hajari.wha.domain;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@Table(uniqueConstraints = @UniqueConstraint(columnNames = { "name" }))
@RooJavaBean
@RooEntity(finders = { "findCustomersByNameEquals" })
public class Customer {

	@NotNull
	@Size(max = 45)
	private String name;

	@Override
	public String toString() {
		return name;
	}

	@Override
	public boolean equals(Object obj) {
		if (null == obj) {
			return false;
		}
		if (!(obj instanceof Customer)) {
			return false;
		}
		Customer c = (Customer) obj;
		if (getId().equals(c.getId())) {
			return true;
		}
		return name.equals(c.getName());
	}
}
