package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.EmployeeConstants;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect EmployeeConstantsController_Roo_Controller {
    
    @RequestMapping(value = "/admin/emp_cons", method = RequestMethod.POST)
    public String EmployeeConstantsController.create(@Valid EmployeeConstants employeeConstants, BindingResult result, ModelMap modelMap) {
        if (employeeConstants == null) throw new IllegalArgumentException("A employeeConstants is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("employeeConstants", employeeConstants);
            modelMap.addAttribute("employees", Employee.findAllEmployees());
            return "admin/emp_cons/create";
        }
        employeeConstants.persist();
        return "redirect:/admin/emp_cons/" + employeeConstants.getId();
    }
    
    @RequestMapping(value = "/admin/emp_cons/form", method = RequestMethod.GET)
    public String EmployeeConstantsController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("employeeConstants", new EmployeeConstants());
        modelMap.addAttribute("employees", Employee.findAllEmployees());
        return "admin/emp_cons/create";
    }
    
    @RequestMapping(value = "/admin/emp_cons/{id}", method = RequestMethod.GET)
    public String EmployeeConstantsController.show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("employeeConstants", EmployeeConstants.findEmployeeConstants(id));
        return "admin/emp_cons/show";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String EmployeeConstantsController.update(@Valid EmployeeConstants employeeConstants, BindingResult result, ModelMap modelMap) {
        if (employeeConstants == null) throw new IllegalArgumentException("A employeeConstants is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("employeeConstants", employeeConstants);
            modelMap.addAttribute("employees", Employee.findAllEmployees());
            return "admin/emp_cons/update";
        }
        employeeConstants.merge();
        return "redirect:/admin/emp_cons/" + employeeConstants.getId();
    }
    
    @RequestMapping(value = "/admin/emp_cons/{id}/form", method = RequestMethod.GET)
    public String EmployeeConstantsController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("employeeConstants", EmployeeConstants.findEmployeeConstants(id));
        modelMap.addAttribute("employees", Employee.findAllEmployees());
        return "admin/emp_cons/update";
    }
    
    @RequestMapping(value = "/admin/emp_cons/{id}", method = RequestMethod.DELETE)
    public String EmployeeConstantsController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        EmployeeConstants.findEmployeeConstants(id).remove();
        return "redirect:/admin/emp_cons?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    @RequestMapping(value = "find/ByEmployee/form", method = RequestMethod.GET)
    public String EmployeeConstantsController.findEmployeeConstantsesByEmployeeForm(ModelMap modelMap) {
        modelMap.addAttribute("employees", Employee.findAllEmployees());
        return "admin/emp_cons/findEmployeeConstantsesByEmployee";
    }
    
    @RequestMapping(value = "find/ByEmployee", method = RequestMethod.GET)
    public String EmployeeConstantsController.findEmployeeConstantsesByEmployee(@RequestParam("employee") Employee employee, ModelMap modelMap) {
        if (employee == null) throw new IllegalArgumentException("A Employee is required.");
        modelMap.addAttribute("employeeconstantses", EmployeeConstants.findEmployeeConstantsesByEmployee(employee).getResultList());
        return "admin/emp_cons/list";
    }
    
    @RequestMapping(value = "find/ByEmployeeAndKeyEquals/form", method = RequestMethod.GET)
    public String EmployeeConstantsController.findEmployeeConstantsesByEmployeeAndKeyEqualsForm(ModelMap modelMap) {
        modelMap.addAttribute("employees", Employee.findAllEmployees());
        return "admin/emp_cons/findEmployeeConstantsesByEmployeeAndKeyEquals";
    }
    
    @RequestMapping(value = "find/ByEmployeeAndKeyEquals", method = RequestMethod.GET)
    public String EmployeeConstantsController.findEmployeeConstantsesByEmployeeAndKeyEquals(@RequestParam("employee") Employee employee, @RequestParam("key") String key, ModelMap modelMap) {
        if (employee == null) throw new IllegalArgumentException("A Employee is required.");
        if (key == null || key.length() == 0) throw new IllegalArgumentException("A Key is required.");
        modelMap.addAttribute("employeeconstantses", EmployeeConstants.findEmployeeConstantsesByEmployeeAndKeyEquals(employee, key).getResultList());
        return "admin/emp_cons/list";
    }
    
}
