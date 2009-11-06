package nl.hajari.wha.domain;

import java.security.SecureRandom;
import java.util.List;
import java.util.Random;
import nl.hajari.wha.domain.Employee;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

privileged aspect EmployeeDataOnDemand_Roo_DataOnDemand {
    
    declare @type: EmployeeDataOnDemand: @Component;    
    
    private Random EmployeeDataOnDemand.rnd = new SecureRandom();    
    
    private List<Employee> EmployeeDataOnDemand.data;    
    
    public Employee EmployeeDataOnDemand.getNewTransientEmployee(int index) {    
        nl.hajari.wha.domain.Employee obj = new nl.hajari.wha.domain.Employee();        
        obj.setEmployeeId("employeeId_" + index);        
        obj.setFirstName("firstName_" + index);        
        obj.setLastName("lastName_" + index);        
        obj.setPayRate(null);        
        return obj;        
    }    
    
    public Employee EmployeeDataOnDemand.getRandomEmployee() {    
        init();        
        return data.get(rnd.nextInt(data.size()));        
    }    
    
    public boolean EmployeeDataOnDemand.modifyEmployee(Employee obj) {    
        return false;        
    }    
    
    @Transactional(propagation = Propagation.REQUIRES_NEW)    
    public void EmployeeDataOnDemand.init() {    
        if (data != null) {        
            return;            
        }        
                
        data = nl.hajari.wha.domain.Employee.findEmployeeEntries(0, 10);        
        if (data == null) throw new IllegalStateException("Find entries implementation for 'Employee' illegally returned null");        
        if (data.size() > 0) {        
            return;            
        }        
                
        data = new java.util.ArrayList<nl.hajari.wha.domain.Employee>();        
        for (int i = 0; i < 10; i++) {        
            nl.hajari.wha.domain.Employee obj = getNewTransientEmployee(i);            
            obj.persist();            
            data.add(obj);            
        }        
    }    
    
}
