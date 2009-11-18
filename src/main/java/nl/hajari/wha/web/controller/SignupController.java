package nl.hajari.wha.web.controller;


import java.util.ArrayList;
import java.util.List;

import nl.hajari.wha.Constants;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.TechRole;
import nl.hajari.wha.domain.User;
import nl.hajari.wha.web.RoleController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.providers.encoding.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

@RequestMapping("/admin/signup/**")
@Controller
@SessionAttributes("newuser")
public class SignupController {
	
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	RoleController roleController;
	
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
			ModelMap modelMap) {
		List<String> errors = new ArrayList<String>();
		List<User> users = User.findUsersByUsernameEquals(newuser.getUsername()).getResultList();
		if (users.size() != 0) { 
			errors.add("error.usernameExists");
		} 
		if (!newuser.getPassword().endsWith(newuser.getConfirmPassword())) {
			errors.add("error.passwordIsNotSame");
			newuser.setPassword(null);
			newuser.setConfirmPassword(null);
		}
		
		if (errors.size() == 0) {
			Employee employee = newuser.getEmployee();
			employee.persist();
			newuser.setEmployee(employee);
			newuser.setPassword(passwordEncoder.encodePassword(newuser.getPassword(),null));
			newuser.addRole(roleController.getRole(Constants.ROLE_EMPLOYEE));
			newuser.persist();
			// we need to set the user for employee and persist again
			employee.setUser(newuser);
			employee.persist();
			
			modelMap.put("user", newuser);
			return "admin/signup/show";
		} else {
			modelMap.put("errors", errors);
			modelMap.put("newuser", newuser);
			modelMap.put("techroles", TechRole.findAllTechRoles());
			return "admin/signup";
		}
	}
}
