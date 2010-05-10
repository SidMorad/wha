package nl.hajari.wha.domain;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.roo.addon.entity.RooEntity;
import org.springframework.roo.addon.javabean.RooJavaBean;

@Entity
@RooJavaBean
@RooEntity(finders = { "findProjectsByNameEquals", "findProjectsByNameLike", "findProjectsByCustomerAndNameEquals" })
public class Project {

	@NotNull
	@Size(max = 45)
	private String name;

	@ManyToOne(targetEntity = Customer.class, fetch = FetchType.LAZY)
	@JoinColumn(name = "customer_id")
	private Customer customer;

	@Override
	public String toString() {
		return name + " @ " + (customer == null ? "Uknown" : customer);
	}

	@Override
	public boolean equals(Object obj) {
		if (null == obj) {
			return false;
		}
		if (!(obj instanceof Project)) {
			return false;
		}
		Project p = (Project) obj;
		if (getId().equals(p.getId())) {
			return true;
		}
		return name.equals(p.getName()) && customer.equals(p.getCustomer());
	}
}
