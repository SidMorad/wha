package nl.hajari.wha.domain;

import nl.hajari.wha.domain.EmpMonthDataOnDemand;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect EmpMonthIntegrationTest_Roo_IntegrationTest {
    
    declare @type: EmpMonthIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);    
    
    declare @type: EmpMonthIntegrationTest: @ContextConfiguration(locations = "classpath:/META-INF/spring/applicationContext.xml");    
    
    @Autowired    
    private EmpMonthDataOnDemand EmpMonthIntegrationTest.dod;    
    
    @Test    
    public void EmpMonthIntegrationTest.testCountEmpMonths() {    
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        long count = nl.hajari.wha.domain.EmpMonth.countEmpMonths();        
        junit.framework.Assert.assertTrue("Counter for 'EmpMonth' incorrectly reported there were no entries", count > 0);        
    }    
    
    @Test    
    public void EmpMonthIntegrationTest.testFindEmpMonth() {    
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        java.lang.Long id = dod.getRandomEmpMonth().getId();        
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to provide an identifier", id);        
        nl.hajari.wha.domain.EmpMonth obj = nl.hajari.wha.domain.EmpMonth.findEmpMonth(id);        
        junit.framework.Assert.assertNotNull("Find method for 'EmpMonth' illegally returned null for id '" + id + "'", obj);        
        junit.framework.Assert.assertEquals("Find method for 'EmpMonth' returned the incorrect identifier", id, obj.getId());        
    }    
    
    @Test    
    public void EmpMonthIntegrationTest.testFindAllEmpMonths() {    
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        long count = nl.hajari.wha.domain.EmpMonth.countEmpMonths();        
        junit.framework.Assert.assertTrue("Too expensive to perform a find all test for 'EmpMonth', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);        
        java.util.List<nl.hajari.wha.domain.EmpMonth> result = nl.hajari.wha.domain.EmpMonth.findAllEmpMonths();        
        junit.framework.Assert.assertNotNull("Find all method for 'EmpMonth' illegally returned null", result);        
        junit.framework.Assert.assertTrue("Find all method for 'EmpMonth' failed to return any data", result.size() > 0);        
    }    
    
    @Test    
    public void EmpMonthIntegrationTest.testFindEmpMonthEntries() {    
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        long count = nl.hajari.wha.domain.EmpMonth.countEmpMonths();        
        if (count > 20) count = 20;        
        java.util.List<nl.hajari.wha.domain.EmpMonth> result = nl.hajari.wha.domain.EmpMonth.findEmpMonthEntries(0, (int)count);        
        junit.framework.Assert.assertNotNull("Find entries method for 'EmpMonth' illegally returned null", result);        
        junit.framework.Assert.assertEquals("Find entries method for 'EmpMonth' returned an incorrect number of entries", count, result.size());        
    }    
    
    @Test    
    @Transactional    
    public void EmpMonthIntegrationTest.testFlush() {    
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        java.lang.Long id = dod.getRandomEmpMonth().getId();        
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to provide an identifier", id);        
        nl.hajari.wha.domain.EmpMonth obj = nl.hajari.wha.domain.EmpMonth.findEmpMonth(id);        
        junit.framework.Assert.assertNotNull("Find method for 'EmpMonth' illegally returned null for id '" + id + "'", obj);        
        boolean modified =  dod.modifyEmpMonth(obj);        
        java.lang.Integer currentVersion = obj.getVersion();        
        obj.flush();        
        junit.framework.Assert.assertTrue("Version for 'EmpMonth' failed to increment on flush directive", obj.getVersion() > currentVersion || !modified);        
    }    
    
    @Test    
    @Transactional    
    public void EmpMonthIntegrationTest.testMerge() {    
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        java.lang.Long id = dod.getRandomEmpMonth().getId();        
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to provide an identifier", id);        
        nl.hajari.wha.domain.EmpMonth obj = nl.hajari.wha.domain.EmpMonth.findEmpMonth(id);        
        junit.framework.Assert.assertNotNull("Find method for 'EmpMonth' illegally returned null for id '" + id + "'", obj);        
        boolean modified =  dod.modifyEmpMonth(obj);        
        java.lang.Integer currentVersion = obj.getVersion();        
        obj.merge();        
        obj.flush();        
        junit.framework.Assert.assertTrue("Version for 'EmpMonth' failed to increment on merge and flush directive", obj.getVersion() > currentVersion || !modified);        
    }    
    
    @Test    
    @Transactional    
    public void EmpMonthIntegrationTest.testPersist() {    
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        nl.hajari.wha.domain.EmpMonth obj = dod.getNewTransientEmpMonth(Integer.MAX_VALUE);        
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to provide a new transient entity", obj);        
        junit.framework.Assert.assertNull("Expected 'EmpMonth' identifier to be null", obj.getId());        
        obj.persist();        
        obj.flush();        
        junit.framework.Assert.assertNotNull("Expected 'EmpMonth' identifier to no longer be null", obj.getId());        
    }    
    
    @Test    
    @Transactional    
    public void EmpMonthIntegrationTest.testRemove() {    
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        java.lang.Long id = dod.getRandomEmpMonth().getId();        
        junit.framework.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to provide an identifier", id);        
        nl.hajari.wha.domain.EmpMonth obj = nl.hajari.wha.domain.EmpMonth.findEmpMonth(id);        
        junit.framework.Assert.assertNotNull("Find method for 'EmpMonth' illegally returned null for id '" + id + "'", obj);        
        obj.remove();        
        junit.framework.Assert.assertNull("Failed to remove 'EmpMonth' with identifier '" + id + "'", nl.hajari.wha.domain.EmpMonth.findEmpMonth(id));        
    }    
    
}
