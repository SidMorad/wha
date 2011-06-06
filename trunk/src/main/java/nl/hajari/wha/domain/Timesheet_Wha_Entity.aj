package nl.hajari.wha.domain;

import java.util.Date;
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
	
	public static Query Timesheet.findAllTimesheetsByEmployeeAndSheetMonthAndSheetYearBetween(Employee employee, Integer fromYear, Integer fromMonth , Integer toYear, Integer toMonth) {
		Query query;
		if (fromYear < toYear) {
			// TODO figure it a way to limit the result with fromMonth and toMonth
			query = entityManager().createQuery("select o from Timesheet o where o.employee.id= :employeeId and o.sheetYear >= :fromYear and o.sheetYear <= :toYear");
		} else {
			query = entityManager().createQuery("select o from Timesheet o where o.employee.id= :employeeId and o.sheetYear >= :fromYear and o.sheetMonth >= :fromMonth and o.sheetYear <= :toYear and o.sheetMonth <= :toMonth");
			query.setParameter("fromMonth", fromMonth);
			query.setParameter("toMonth", toMonth);
		}
		query.setParameter("employeeId", employee.getId());
		query.setParameter("fromYear", fromYear);
		query.setParameter("toYear", toYear);
		return query; 	
	}
	
	public static Query Timesheet.findTimesheetsByEmployeeWithDateRange(Employee employee, Date from, Date to) {
		Query q = null;
		String query = "select dt.project, sum(dt.dailyTotalDuration), sum(dt.durationOffs), sum(dt.durationSickness), sum(dt.durationTraining) " +
				"from DailyTimesheet dt, Timesheet t, Employee e, Project p " +
				"where e.id = :employeeId and dt.timesheet.id = t.id and t.employee.id = e.id and dt.project.id = p.id and " +
				"dt.dayDate between :fromDate and :toDate group by dt.project";
		q = entityManager().createQuery(query);
		q.setParameter("fromDate", from);
		q.setParameter("toDate", to);
		q.setParameter("employeeId", employee.getId());
		return q;
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
    
    public static List<Timesheet> Timesheet.findTimesheetEntriesByEmployeeId(Long employeeId) {    
    	Query query = entityManager().createQuery("select o from Timesheet o where o.employee.id= :employeeId");
    	query.setParameter("employeeId", employeeId);
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
