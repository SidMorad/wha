package nl.hajari.wha.domain;

import java.util.List;

import javax.persistence.Query;

import nl.hajari.wha.web.util.DateUtils;

import org.springframework.transaction.annotation.Transactional;

privileged aspect Timesheet_Wha_Entity {

	@Transactional
	public static int Timesheet.updateTimesheetTotalMonthly(Long id, Float total) {
		Timesheet timesheet = Timesheet.findTimesheet(id);
		timesheet.setMonthlyTotal(total);
		timesheet.merge();
		timesheet.flush();
		return 0;
	}
	
	public static Query Timesheet.findEmployeeCurrentTimesheet(Long employeeId) {
		Employee employee = Employee.findEmployee(employeeId);
		Query query = Timesheet.findTimesheetsByEmployeeAndSheetMonthAndSheetYearEquals(employee, DateUtils
				.getCurrentMonth(), DateUtils.getCurrentYear());
		return query;
	}

    public static List<Timesheet> Timesheet.findAllTimesheetsByEmployeeId(Long employeeId) {    
    	Query query = entityManager().createQuery("select o from Timesheet o where o.employee.id= :employeeId");
    	query.setParameter("employeeId", employeeId);
    	return query.getResultList();
    }    
	
    public static List<Timesheet> Timesheet.findTimesheetEntriesByEmployeeId(Long employeeId,int firstResult, int maxResults) {    
        Query query = entityManager().createQuery("select o from Timesheet o where o.employee.id= :employeeId");
        query.setParameter("employeeId", employeeId);
        query.setFirstResult(firstResult);
        query.setMaxResults(maxResults);
        return query.getResultList();
    } 
    
}
