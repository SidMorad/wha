package nl.hajari.wha.domain;

import java.security.SecureRandom;
import java.util.List;
import java.util.Random;
import nl.hajari.wha.domain.EmpMonth;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

privileged aspect EmpMonthDataOnDemand_Roo_DataOnDemand {
    
    declare @type: EmpMonthDataOnDemand: @Component;    
    
    private Random EmpMonthDataOnDemand.rnd = new SecureRandom();    
    
    private List<EmpMonth> EmpMonthDataOnDemand.data;    
    
    public EmpMonth EmpMonthDataOnDemand.getNewTransientEmpMonth(int index) {    
        nl.hajari.wha.domain.EmpMonth obj = new nl.hajari.wha.domain.EmpMonth();        
        obj.setNumber("number_" + index);        
        return obj;        
    }    
    
    public EmpMonth EmpMonthDataOnDemand.getRandomEmpMonth() {    
        init();        
        return data.get(rnd.nextInt(data.size()));        
    }    
    
    public boolean EmpMonthDataOnDemand.modifyEmpMonth(EmpMonth obj) {    
        return false;        
    }    
    
    @Transactional(propagation = Propagation.REQUIRES_NEW)    
    public void EmpMonthDataOnDemand.init() {    
        if (data != null) {        
            return;            
        }        
                
        data = nl.hajari.wha.domain.EmpMonth.findEmpMonthEntries(0, 10);        
        if (data == null) throw new IllegalStateException("Find entries implementation for 'EmpMonth' illegally returned null");        
        if (data.size() > 0) {        
            return;            
        }        
                
        data = new java.util.ArrayList<nl.hajari.wha.domain.EmpMonth>();        
        for (int i = 0; i < 10; i++) {        
            nl.hajari.wha.domain.EmpMonth obj = getNewTransientEmpMonth(i);            
            obj.persist();            
            data.add(obj);            
        }        
    }    
    
}
