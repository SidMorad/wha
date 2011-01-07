package nl.hajari.wha.domain;

import java.lang.String;

privileged aspect Constants_Roo_JavaBean {
    
    public String Constants.getKey() {
        return this.key;
    }
    
    public void Constants.setKey(String key) {
        this.key = key;
    }
    
    public String Constants.getValue() {
        return this.value;
    }
    
    public void Constants.setValue(String value) {
        this.value = value;
    }
    
}
