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

    public static List<Timesheet> Timesheet.findTimesheetEntriesByEmployeeIdAndCurrentYear(Long employeeId) {    
    	Integer currentYear = DateUtils.getCurrentYear();
    	Query query = entityManager().createQuery("select o from Timesheet o where o.employee.id= :employeeId and o.sheetYear= :currentYear");
    	query.setParameter("employeeId", employeeId);
    	query.setParameter("currentYear", currentYear);
    	return query.getResultList();
    } 
    
	public static List<Timesheet> Timesheet.findTimesheetEntriesByYearAndMonth(int firstResult, int maxResults, Integer year, Integer month, boolean archived) {
		year = (year == null ? DateUtils.getCurrentYear() : year);
		month = (month == null ? DateUtils.getCurrentMonth() : month);
		Query query = entityManager().createQuery("select o from Timesheet o where o.sheetYear= :sheetYear and o.sheetMonth= :sheetMonth and o.archived= :archived");
		query.setParameter("sheetYear", year);
		query.setParameter("sheetMonth", month);
		query.setParameter("archived", archived);
		if (firstResult != -1) {
			query.setFirstResult(firstResult);
		}
		if (maxResults != -1) {
			query.setMaxResults(maxResults);
		}
		return query.getResultList();
	}
}
