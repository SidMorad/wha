package nl.hajari.wha.domain;

import java.lang.String;
import nl.hajari.wha.domain.Customer;

privileged aspect Project_Roo_JavaBean {
    
    public String Project.getName() {
        return this.name;
    }
    
    public void Project.setName(String name) {
        this.name = name;
    }
    
    public Customer Project.getCustomer() {
        return this.customer;
    }
    
    public void Project.setCustomer(Customer customer) {
        this.customer = customer;
    }
    
}
