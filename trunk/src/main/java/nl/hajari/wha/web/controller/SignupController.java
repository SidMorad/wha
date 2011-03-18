package nl.hajari.wha.web.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import nl.hajari.wha.Constants;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.EmployeeConstants;
import nl.hajari.wha.domain.TechRole;
import nl.hajari.wha.domain.User;
import nl.hajari.wha.service.impl.EmployeeConstantsServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@RequestMapping("/admin/signup/**")
@Controller
@SessionAttributes("newuser")
public class SignupController extends AbstractController {

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	RoleController roleController;
	
	@Autowired
	EmployeeConstantsServiceImpl employeeConstantsService;

	@RequestMapping
	public String get(ModelMap modelMap) {
		User newuser = new User();
		Employee newemployee = new Employee();
		newuser.setEmployee(newemployee);
		modelMap.put("newuser", newuser);
		modelMap.put("techroles", TechRole.findAllTechRoles());
		return "admin/signup";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String post(@ModelAttribute("newuser") User newuser,
			ModelMap modelMap, HttpServletRequest request) {
		List<String> errors = new ArrayList<String>();
		List<User> users = User.findUsersByUsernameEquals(newuser.getUsername()).getResultList();
		if (users.size() != 0) {
			errors.add("error.usernameExists");
		}
		List<Employee> employees = Employee.findEmployeesByEmpId(newuser.getEmployee().getEmpId()).getResultList();
		if (employees.size() != 0) {
			errors.add("error.empIdExists");
		}
		if (!newuser.getPassword().endsWith(newuser.getConfirmPassword())) {
			errors.add("error.passwordIsNotSame");
			newuser.setPassword(null);
			newuser.setConfirmPassword(null);
		}
		
		List<EmployeeConstants> ecList = employeeConstantsService.getEmployeeConstantsListFromRequest(request);

		if (errors.size() == 0) {
			Employee employee = newuser.getEmployee();
			employee.persist();
			newuser.setEmployee(employee);
			newuser.setPassword(passwordEncoder.encodePassword(newuser.getPassword(), null));
			newuser.addRole(roleController.getRole(Constants.ROLE_EMPLOYEE));
			newuser.persist();
			// we need to set the user for employee and persist again
			employee.setUser(newuser);
			employee.persist();
			employeeConstantsService.persistEmployeeConstantsListWithEmployee(ecList, employee);
			modelMap.put("user", newuser);
			modelMap.put("employeeconstantses", ecList);
			return "admin/signup/show";
		} else {
			modelMap.put("errors", errors);
			modelMap.put("newuser", newuser);
			modelMap.put("techroles", TechRole.findAllTechRoles());
			modelMap.put("employeeconstantses", ecList);
			return "admin/signup";
		}
	}

}
