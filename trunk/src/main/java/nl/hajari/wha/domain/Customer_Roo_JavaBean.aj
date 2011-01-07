package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect Customer_Roo_JavaBean {
    
    public String Customer.getName() {
        return this.name;
    }
    
    public void Customer.setName(String name) {
        this.name = name;
    }
    
}
