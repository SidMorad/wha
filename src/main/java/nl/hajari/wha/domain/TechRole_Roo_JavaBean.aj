package nl.hajari.wha.domain;

import java.lang.Float;
import java.lang.String;

privileged aspect TechRole_Roo_JavaBean {
    
    public String TechRole.getName() {
        return this.name;
    }
    
    public void TechRole.setName(String name) {
        this.name = name;
    }
    
    public Float TechRole.getHourlyWage() {
        return this.hourlyWage;
    }
    
    public void TechRole.setHourlyWage(Float hourlyWage) {
        this.hourlyWage = hourlyWage;
    }
    
}
