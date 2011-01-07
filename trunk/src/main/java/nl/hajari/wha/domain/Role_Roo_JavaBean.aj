package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect Role_Roo_JavaBean {
    
    public String Role.getName() {
        return this.name;
    }
    
    public void Role.setName(String name) {
        this.name = name;
    }
    
}
