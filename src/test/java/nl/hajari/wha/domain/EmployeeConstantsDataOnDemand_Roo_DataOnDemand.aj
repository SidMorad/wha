package nl.hajari.wha.domain;

import java.security.SecureRandom;
import java.util.List;
import java.util.Random;
import nl.hajari.wha.domain.EmployeeConstants;
import nl.hajari.wha.domain.EmployeeDataOnDemand;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

privileged aspect EmployeeConstantsDataOnDemand_Roo_DataOnDemand {
    
    declare @type: EmployeeConstantsDataOnDemand: @Component;
    
    private Random EmployeeConstantsDataOnDemand.rnd = new SecureRandom();
    
    private List<EmployeeConstants> EmployeeConstantsDataOnDemand.data;
    
    @Autowired
    private EmployeeDataOnDemand EmployeeConstantsDataOnDemand.employeeDataOnDemand;
    
    public EmployeeConstants EmployeeConstantsDataOnDemand.getNewTransientEmployeeConstants(int index) {
        nl.hajari.wha.domain.EmployeeConstants obj = new nl.hajari.wha.domain.EmployeeConstants();
        obj.setEmployee(employeeDataOnDemand.getRandomEmployee());
        obj.setKey("key_" + index);
        obj.setValue("value_" + index);
        return obj;
    }
    
    public EmployeeConstants EmployeeConstantsDataOnDemand.getSpecificEmployeeConstants(int index) {
        init();
        if (index < 0) index = 0;
        if (index > (data.size()-1)) index = data.size() - 1;
        EmployeeConstants obj = data.get(index);
        return EmployeeConstants.findEmployeeConstants(obj.getId());
    }
    
    public EmployeeConstants EmployeeConstantsDataOnDemand.getRandomEmployeeConstants() {
        init();
        EmployeeConstants obj = data.get(rnd.nextInt(data.size()));
        return EmployeeConstants.findEmployeeConstants(obj.getId());
    }
    
    public boolean EmployeeConstantsDataOnDemand.modifyEmployeeConstants(EmployeeConstants obj) {
        return false;
    }
    
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void EmployeeConstantsDataOnDemand.init() {
        if (data != null) {
            return;
        }
        
        data = nl.hajari.wha.domain.EmployeeConstants.findEmployeeConstantsEntries(0, 10);
        if (data == null) throw new IllegalStateException("Find entries implementation for 'EmployeeConstants' illegally returned null");
        if (data.size() > 0) {
            return;
        }
        
        data = new java.util.ArrayList<nl.hajari.wha.domain.EmployeeConstants>();
        for (int i = 0; i < 10; i++) {
            nl.hajari.wha.domain.EmployeeConstants obj = getNewTransientEmployeeConstants(i);
            obj.persist();
            data.add(obj);
        }
    }
    
}
