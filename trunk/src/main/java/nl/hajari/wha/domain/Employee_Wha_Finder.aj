package nl.hajari.wha.domain;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.util.StringUtils;

privileged aspect Employee_Wha_Finder {
    
	public static Query Employee.findEmployeesByRole(String role) {
		if (!StringUtils.hasText(role)) {
			throw new IllegalArgumentException("The role argument is required.");
		}
		EntityManager em = Employee.entityManager();
		Query q = em.createQuery(
				"SELECT distinct e " +
				"FROM Employee AS e, IN (e.user.roles) r " +
				"WHERE r.name = :role"
				);
		q.setParameter("role", role);
		return q;
	} 
    
}
