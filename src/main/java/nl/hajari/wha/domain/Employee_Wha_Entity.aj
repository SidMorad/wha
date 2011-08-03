package nl.hajari.wha.domain;

import java.util.List;

import javax.persistence.Query;

privileged aspect Employee_Wha_Entity {
	
	public static List<Employee> Employee.findAllActiveEmployees() {
		return Employee.findEmployeesByArchived(false).getResultList();
	}
	
	public static List<Employee> Employee.findEmployeeEntriesByArchived(int firstResult, int maxResults, boolean archived) {
		Query query= entityManager().createQuery("select o from Employee o where o.archived= :archived");
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
