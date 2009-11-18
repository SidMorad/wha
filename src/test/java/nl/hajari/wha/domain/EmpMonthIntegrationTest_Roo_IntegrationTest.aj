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
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        long count = nl.hajari.wha.domain.EmpMonth.countEmpMonths();        
        org.junit.Assert.assertTrue("Counter for 'EmpMonth' incorrectly reported there were no entries", count > 0);        
    }    
    
    @Test    
    public void EmpMonthIntegrationTest.testFindEmpMonth() {    
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        java.lang.Long id = dod.getRandomEmpMonth().getId();        
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to provide an identifier", id);        
        nl.hajari.wha.domain.EmpMonth obj = nl.hajari.wha.domain.EmpMonth.findEmpMonth(id);        
        org.junit.Assert.assertNotNull("Find method for 'EmpMonth' illegally returned null for id '" + id + "'", obj);        
        org.junit.Assert.assertEquals("Find method for 'EmpMonth' returned the incorrect identifier", id, obj.getId());        
    }    
    
    @Test    
    public void EmpMonthIntegrationTest.testFindAllEmpMonths() {    
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        long count = nl.hajari.wha.domain.EmpMonth.countEmpMonths();        
        org.junit.Assert.assertTrue("Too expensive to perform a find all test for 'EmpMonth', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);        
        java.util.List<nl.hajari.wha.domain.EmpMonth> result = nl.hajari.wha.domain.EmpMonth.findAllEmpMonths();        
        org.junit.Assert.assertNotNull("Find all method for 'EmpMonth' illegally returned null", result);        
        org.junit.Assert.assertTrue("Find all method for 'EmpMonth' failed to return any data", result.size() > 0);        
    }    
    
    @Test    
    public void EmpMonthIntegrationTest.testFindEmpMonthEntries() {    
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        long count = nl.hajari.wha.domain.EmpMonth.countEmpMonths();        
        if (count > 20) count = 20;        
        java.util.List<nl.hajari.wha.domain.EmpMonth> result = nl.hajari.wha.domain.EmpMonth.findEmpMonthEntries(0, (int)count);        
        org.junit.Assert.assertNotNull("Find entries method for 'EmpMonth' illegally returned null", result);        
        org.junit.Assert.assertEquals("Find entries method for 'EmpMonth' returned an incorrect number of entries", count, result.size());        
    }    
    
    @Test    
    @Transactional    
    public void EmpMonthIntegrationTest.testFlush() {    
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        java.lang.Long id = dod.getRandomEmpMonth().getId();        
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to provide an identifier", id);        
        nl.hajari.wha.domain.EmpMonth obj = nl.hajari.wha.domain.EmpMonth.findEmpMonth(id);        
        org.junit.Assert.assertNotNull("Find method for 'EmpMonth' illegally returned null for id '" + id + "'", obj);        
        boolean modified =  dod.modifyEmpMonth(obj);        
        java.lang.Integer currentVersion = obj.getVersion();        
        obj.flush();        
        org.junit.Assert.assertTrue("Version for 'EmpMonth' failed to increment on flush directive", obj.getVersion() > currentVersion || !modified);        
    }    
    
    @Test    
    @Transactional    
    public void EmpMonthIntegrationTest.testMerge() {    
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        java.lang.Long id = dod.getRandomEmpMonth().getId();        
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to provide an identifier", id);        
        nl.hajari.wha.domain.EmpMonth obj = nl.hajari.wha.domain.EmpMonth.findEmpMonth(id);        
        org.junit.Assert.assertNotNull("Find method for 'EmpMonth' illegally returned null for id '" + id + "'", obj);        
        boolean modified =  dod.modifyEmpMonth(obj);        
        java.lang.Integer currentVersion = obj.getVersion();        
        obj.merge();        
        obj.flush();        
        org.junit.Assert.assertTrue("Version for 'EmpMonth' failed to increment on merge and flush directive", obj.getVersion() > currentVersion || !modified);        
    }    
    
    @Test    
    @Transactional    
    public void EmpMonthIntegrationTest.testPersist() {    
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        nl.hajari.wha.domain.EmpMonth obj = dod.getNewTransientEmpMonth(Integer.MAX_VALUE);        
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to provide a new transient entity", obj);        
        org.junit.Assert.assertNull("Expected 'EmpMonth' identifier to be null", obj.getId());        
        obj.persist();        
        obj.flush();        
        org.junit.Assert.assertNotNull("Expected 'EmpMonth' identifier to no longer be null", obj.getId());        
    }    
    
    @Test    
    @Transactional    
    public void EmpMonthIntegrationTest.testRemove() {    
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to initialize correctly", dod.getRandomEmpMonth());        
        java.lang.Long id = dod.getRandomEmpMonth().getId();        
        org.junit.Assert.assertNotNull("Data on demand for 'EmpMonth' failed to provide an identifier", id);        
        nl.hajari.wha.domain.EmpMonth obj = nl.hajari.wha.domain.EmpMonth.findEmpMonth(id);        
        org.junit.Assert.assertNotNull("Find method for 'EmpMonth' illegally returned null for id '" + id + "'", obj);        
        obj.remove();        
        org.junit.Assert.assertNull("Failed to remove 'EmpMonth' with identifier '" + id + "'", nl.hajari.wha.domain.EmpMonth.findEmpMonth(id));        
    }    
    
}
