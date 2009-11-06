package nl.hajari.wha.domain;

import java.lang.String;
import java.math.BigDecimal;

privileged aspect TechnicalRole_Roo_JavaBean {
    
    public String TechnicalRole.getName() {    
        return this.name;        
    }    
    
    public void TechnicalRole.setName(String name) {    
        this.name = name;        
    }    
    
    public BigDecimal TechnicalRole.getPayRate() {    
        return this.payRate;        
    }    
    
    public void TechnicalRole.setPayRate(BigDecimal payRate) {    
        this.payRate = payRate;        
    }    
    
}
