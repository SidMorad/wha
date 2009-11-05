package nl.hajari.wha.web;

import java.lang.Long;
import java.lang.String;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.User;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect EmployeeController_Roo_Controller {
    
    @RequestMapping(value = "/employee", method = RequestMethod.POST)    
    public String EmployeeController.create(@ModelAttribute("employee") Employee employee, BindingResult result, ModelMap modelMap) {    
        if (employee == null) throw new IllegalArgumentException("A employee is required");        
        for (ConstraintViolation<Employee> constraint : Validation.buildDefaultValidatorFactory().getValidator().validate(employee)) {        
            result.rejectValue(constraint.getPropertyPath().toString(), "employee.error." + constraint.getPropertyPath(), constraint.getMessage());            
        }        
        if (result.hasErrors()) {        
            modelMap.addAllAttributes(result.getAllErrors());            
            modelMap.addAttribute("employee", employee);            
            modelMap.addAttribute("users", User.findAllUsers());            
            return "employee/create";            
        }        
        employee.persist();        
        return "redirect:/employee/" + employee.getId();        
    }    
    
    @RequestMapping(value = "/employee/form", method = RequestMethod.GET)    
    public String EmployeeController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("employee", new Employee());        
        modelMap.addAttribute("users", User.findAllUsers());        
        return "employee/create";        
    }    
    
    @RequestMapping(value = "/employee/{id}", method = RequestMethod.GET)    
    public String EmployeeController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("employee", Employee.findEmployee(id));        
        return "employee/show";        
    }    
    
    @RequestMapping(value = "/employee", method = RequestMethod.GET)    
    public String EmployeeController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("employees", Employee.findEmployeeEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) Employee.countEmployees() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("employees", Employee.findAllEmployees());            
        }        
        return "employee/list";        
    }    
    
    @RequestMapping(method = RequestMethod.PUT)    
    public String EmployeeController.update(@ModelAttribute("employee") Employee employee, BindingResult result, ModelMap modelMap) {    
        if (employee == null) throw new IllegalArgumentException("A employee is required");        
        for (ConstraintViolation<Employee> constraint : Validation.buildDefaultValidatorFactory().getValidator().validate(employee)) {        
            result.rejectValue(constraint.getPropertyPath().toString(), "employee.error." + constraint.getPropertyPath(), constraint.getMessage());            
        }        
        if (result.hasErrors()) {        
            modelMap.addAllAttributes(result.getAllErrors());            
            modelMap.addAttribute("employee", employee);            
            modelMap.addAttribute("users", User.findAllUsers());            
            return "employee/update";            
        }        
        employee.merge();        
        return "redirect:/employee/" + employee.getId();        
    }    
    
    @RequestMapping(value = "/employee/{id}/form", method = RequestMethod.GET)    
    public String EmployeeController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("employee", Employee.findEmployee(id));        
        modelMap.addAttribute("users", User.findAllUsers());        
        return "employee/update";        
    }    
    
    @RequestMapping(value = "/employee/{id}", method = RequestMethod.DELETE)    
    public String EmployeeController.delete(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        Employee.findEmployee(id).remove();        
        return "redirect:/employee";        
    }    
    
    @InitBinder    
    public void EmployeeController.initBinder(WebDataBinder binder) {    
        binder.registerCustomEditor(java.util.Date.class, new org.springframework.beans.propertyeditors.CustomDateEditor(new java.text.SimpleDateFormat("d/MM/yy"), true));        
    }    
    
}
