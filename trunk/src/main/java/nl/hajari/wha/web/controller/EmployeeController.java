package nl.hajari.wha.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.EmployeeConstants;
import nl.hajari.wha.domain.TechRole;
import nl.hajari.wha.domain.User;
import nl.hajari.wha.service.impl.EmployeeConstantsServiceImpl;
import nl.hajari.wha.web.controller.formbean.ProfileFormBean;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RooWebScaffold(path = "employee", automaticallyMaintainView = false, formBackingObject = Employee.class, exposeFinders = false)
@RequestMapping("/employee/**")
@Controller
public class EmployeeController extends AbstractController{
	
	@Autowired
	protected PasswordEncoder passwordEncoder; 
	
	@Autowired
	protected EmployeeConstantsServiceImpl employeeConstantsService;

    @RequestMapping(value = "/employee/{id}/form", method = RequestMethod.GET)
    public String updateForm(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("employee", Employee.findEmployee(id));
        modelMap.addAttribute("techroles", TechRole.findAllTechRoles());
        modelMap.addAttribute("users", User.findAllUsers());
        modelMap.addAttribute("employeeconstantses", EmployeeConstants.findEmployeeConstantsesByEmployee(Employee.findEmployee(id)).getResultList());
        return "employee/update";
    }
	
    @RequestMapping(method = RequestMethod.PUT)
    public String update(@Valid Employee employee, BindingResult result, ModelMap modelMap, HttpServletRequest request) {
        if (employee == null) throw new IllegalArgumentException("A employee is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("employee", employee);
            modelMap.addAttribute("techroles", TechRole.findAllTechRoles());
            modelMap.addAttribute("users", User.findAllUsers());
            modelMap.addAttribute("employeeconstantses", employeeConstantsService.getEmployeeConstantsListFromRequest(request));
            return "employee/update";
        }
        employee.merge();
        employeeConstantsService.persistEmployeeConstantsListWithEmployee(employeeConstantsService.getEmployeeConstantsListFromRequest(request), employee);
        return "redirect:/employee/" + employee.getId();
    }
	
    @RequestMapping(value = "/employee/{id}", method = RequestMethod.GET)
    public String show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        Employee employee = Employee.findEmployee(id);
        modelMap.addAttribute("employee", employee);
        modelMap.addAttribute("employeeconstantses", EmployeeConstants.findEmployeeConstantsesByEmployee(employee).getResultList());
        return "employee/show";
    }
    
	@RequestMapping(value = "/employee/profile/form", method = RequestMethod.GET)
	public String prepareProfile(ModelMap modelMap, HttpServletRequest request) {
		Long employeeId = (Long) request.getSession().getAttribute(
				Employee.EMPLOYEE_ID);
		Employee employee = Employee.findEmployee(employeeId);
		
		ProfileFormBean profileFormBean = putEmployeeToProfileFormBean(employee, new ProfileFormBean());
		
		modelMap.addAttribute("profileFormBean", profileFormBean);
		return "employee/profile";
	}


	@RequestMapping(value = "/employee/profile", method = RequestMethod.POST)
	public String updateProfile(@Valid ProfileFormBean profileFormBean,BindingResult result, HttpServletRequest request,
			ModelMap modelMap) {
		if (profileFormBean == null) {
			throw new IllegalArgumentException("A profileFormBean is required");
		}
		if (!profileFormBean.getPassword().equals(profileFormBean.getConfirmPassword())) {
			result.rejectValue("password", "error.passwordIsNotSame");
		}
		
		if (result.hasErrors()) {
			return "employee/profile";
		}
		
		Long employeeId = (Long) request.getSession().getAttribute(
				Employee.EMPLOYEE_ID);
		Employee employee = Employee.findEmployee(employeeId);
		employee = putProfileFormBeanToEmployee(profileFormBean, employee);
		employee.merge();
		logger.debug("Employee [" + employee + "] updated successfully");
		return "redirect:/employee/profile";
	}
	
    @RequestMapping(value = "/employee/profile", method = RequestMethod.GET)    
    public String showProfile(HttpServletRequest request, ModelMap modelMap) {    
    	Long employeeId = (Long) request.getSession().getAttribute(
    			Employee.EMPLOYEE_ID);
        if (employeeId == null) throw new IllegalArgumentException("An Identifier is required");
        
        modelMap.addAttribute("employee", Employee.findEmployee(employeeId));  
        return "employee/profile/show";        
    }   

	private ProfileFormBean putEmployeeToProfileFormBean(Employee employee, ProfileFormBean profileFormBean) {
		profileFormBean.setId(employee.getId());
		profileFormBean.setVersion(employee.getVersion());
		profileFormBean.setEmail(employee.getUser().getEmail());
		return profileFormBean;
	}
	
	private Employee putProfileFormBeanToEmployee(ProfileFormBean profileFormBean, Employee employee) {
		employee.setId(profileFormBean.getId());
		employee.setVersion(profileFormBean.getVersion());
		employee.getUser().setPassword(passwordEncoder.encodePassword(profileFormBean.getPassword(), null));
		employee.getUser().setEmail(profileFormBean.getEmail());
		return employee;
	}

}

