package nl.hajari.wha.domain;

import nl.hajari.wha.domain.EmployeeConstantsDataOnDemand;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect EmployeeConstantsIntegrationTest_Roo_IntegrationTest {
    
    declare @type: EmployeeConstantsIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: EmployeeConstantsIntegrationTest: @ContextConfiguration(locations = "classpath:/META-INF/spring/applicationContext.xml");
    
    @Autowired
    private EmployeeConstantsDataOnDemand EmployeeConstantsIntegrationTest.dod;
    
    @Test
    public void EmployeeConstantsIntegrationTest.testCountEmployeeConstantses() {
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to initialize correctly", dod.getRandomEmployeeConstants());
        long count = nl.hajari.wha.domain.EmployeeConstants.countEmployeeConstantses();
        org.junit.Assert.assertTrue("Counter for 'EmployeeConstants' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void EmployeeConstantsIntegrationTest.testFindEmployeeConstants() {
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to initialize correctly", dod.getRandomEmployeeConstants());
        java.lang.Long id = dod.getRandomEmployeeConstants().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to provide an identifier", id);
        nl.hajari.wha.domain.EmployeeConstants obj = nl.hajari.wha.domain.EmployeeConstants.findEmployeeConstants(id);
        org.junit.Assert.assertNotNull("Find method for 'EmployeeConstants' illegally returned null for id '" + id + "'", obj);
        org.junit.Assert.assertEquals("Find method for 'EmployeeConstants' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void EmployeeConstantsIntegrationTest.testFindAllEmployeeConstantses() {
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to initialize correctly", dod.getRandomEmployeeConstants());
        long count = nl.hajari.wha.domain.EmployeeConstants.countEmployeeConstantses();
        org.junit.Assert.assertTrue("Too expensive to perform a find all test for 'EmployeeConstants', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        java.util.List<nl.hajari.wha.domain.EmployeeConstants> result = nl.hajari.wha.domain.EmployeeConstants.findAllEmployeeConstantses();
        org.junit.Assert.assertNotNull("Find all method for 'EmployeeConstants' illegally returned null", result);
        org.junit.Assert.assertTrue("Find all method for 'EmployeeConstants' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void EmployeeConstantsIntegrationTest.testFindEmployeeConstantsEntries() {
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to initialize correctly", dod.getRandomEmployeeConstants());
        long count = nl.hajari.wha.domain.EmployeeConstants.countEmployeeConstantses();
        if (count > 20) count = 20;
        java.util.List<nl.hajari.wha.domain.EmployeeConstants> result = nl.hajari.wha.domain.EmployeeConstants.findEmployeeConstantsEntries(0, (int)count);
        org.junit.Assert.assertNotNull("Find entries method for 'EmployeeConstants' illegally returned null", result);
        org.junit.Assert.assertEquals("Find entries method for 'EmployeeConstants' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    @Transactional
    public void EmployeeConstantsIntegrationTest.testFlush() {
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to initialize correctly", dod.getRandomEmployeeConstants());
        java.lang.Long id = dod.getRandomEmployeeConstants().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to provide an identifier", id);
        nl.hajari.wha.domain.EmployeeConstants obj = nl.hajari.wha.domain.EmployeeConstants.findEmployeeConstants(id);
        org.junit.Assert.assertNotNull("Find method for 'EmployeeConstants' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyEmployeeConstants(obj);
        java.lang.Integer currentVersion = obj.getVersion();
        obj.flush();
        org.junit.Assert.assertTrue("Version for 'EmployeeConstants' failed to increment on flush directive", obj.getVersion() > currentVersion || !modified);
    }
    
    @Test
    @Transactional
    public void EmployeeConstantsIntegrationTest.testMerge() {
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to initialize correctly", dod.getRandomEmployeeConstants());
        java.lang.Long id = dod.getRandomEmployeeConstants().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to provide an identifier", id);
        nl.hajari.wha.domain.EmployeeConstants obj = nl.hajari.wha.domain.EmployeeConstants.findEmployeeConstants(id);
        org.junit.Assert.assertNotNull("Find method for 'EmployeeConstants' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyEmployeeConstants(obj);
        java.lang.Integer currentVersion = obj.getVersion();
        obj.merge();
        obj.flush();
        org.junit.Assert.assertTrue("Version for 'EmployeeConstants' failed to increment on merge and flush directive", obj.getVersion() > currentVersion || !modified);
    }
    
    @Test
    @Transactional
    public void EmployeeConstantsIntegrationTest.testPersist() {
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to initialize correctly", dod.getRandomEmployeeConstants());
        nl.hajari.wha.domain.EmployeeConstants obj = dod.getNewTransientEmployeeConstants(Integer.MAX_VALUE);
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to provide a new transient entity", obj);
        org.junit.Assert.assertNull("Expected 'EmployeeConstants' identifier to be null", obj.getId());
        obj.persist();
        obj.flush();
        org.junit.Assert.assertNotNull("Expected 'EmployeeConstants' identifier to no longer be null", obj.getId());
    }
    
    @Test
    @Transactional
    public void EmployeeConstantsIntegrationTest.testRemove() {
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to initialize correctly", dod.getRandomEmployeeConstants());
        java.lang.Long id = dod.getRandomEmployeeConstants().getId();
        org.junit.Assert.assertNotNull("Data on demand for 'EmployeeConstants' failed to provide an identifier", id);
        nl.hajari.wha.domain.EmployeeConstants obj = nl.hajari.wha.domain.EmployeeConstants.findEmployeeConstants(id);
        org.junit.Assert.assertNotNull("Find method for 'EmployeeConstants' illegally returned null for id '" + id + "'", obj);
        obj.remove();
        org.junit.Assert.assertNull("Failed to remove 'EmployeeConstants' with identifier '" + id + "'", nl.hajari.wha.domain.EmployeeConstants.findEmployeeConstants(id));
    }
    
}
