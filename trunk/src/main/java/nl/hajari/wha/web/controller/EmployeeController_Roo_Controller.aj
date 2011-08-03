package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.TechRole;
import nl.hajari.wha.domain.User;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect EmployeeController_Roo_Controller {
    
    @RequestMapping(value = "/employee", method = RequestMethod.POST)
    public String EmployeeController.create(@Valid Employee employee, BindingResult result, ModelMap modelMap) {
        if (employee == null) throw new IllegalArgumentException("A employee is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("employee", employee);
            modelMap.addAttribute("techroles", TechRole.findAllTechRoles());
            modelMap.addAttribute("users", User.findAllUsers());
            return "employee/create";
        }
        employee.persist();
        return "redirect:/employee/" + employee.getId();
    }
    
    @RequestMapping(value = "/employee/form", method = RequestMethod.GET)
    public String EmployeeController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("employee", new Employee());
        modelMap.addAttribute("techroles", TechRole.findAllTechRoles());
        modelMap.addAttribute("users", User.findAllUsers());
        return "employee/create";
    }
    
    @RequestMapping(value = "/employee/{id}", method = RequestMethod.DELETE)
    public String EmployeeController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        Employee.findEmployee(id).remove();
        return "redirect:/employee?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
}
