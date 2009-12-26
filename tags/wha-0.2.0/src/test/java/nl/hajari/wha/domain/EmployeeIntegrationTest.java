package nl.hajari.wha.domain;

import org.springframework.roo.addon.test.RooIntegrationTest;
import nl.hajari.wha.domain.Employee;
import org.junit.Test;

@RooIntegrationTest(entity = Employee.class)
public class EmployeeIntegrationTest {

    @Test
    public void testMarkerMethod() {
    }
}
