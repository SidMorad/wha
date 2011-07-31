package nl.hajari.wha.domain;

import java.util.List;

privileged aspect Employee_Wha_Entity {
	
	public static List<Employee> Employee.findAllActiveEmployees() {
		return Employee.findEmployeesByArchived(false).getResultList();
	}
}
