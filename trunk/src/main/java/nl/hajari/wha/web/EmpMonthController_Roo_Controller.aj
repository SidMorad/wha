package nl.hajari.wha.web;

import java.lang.Long;
import java.lang.String;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import nl.hajari.wha.domain.EmpMonth;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.MonthStatus;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect EmpMonthController_Roo_Controller {
    
    @RequestMapping(value = "/empmonth", method = RequestMethod.POST)    
    public String EmpMonthController.create(@ModelAttribute("empmonth") EmpMonth empmonth, BindingResult result, ModelMap modelMap) {    
        if (empmonth == null) throw new IllegalArgumentException("A empmonth is required");        
        for (ConstraintViolation<EmpMonth> constraint : Validation.buildDefaultValidatorFactory().getValidator().validate(empmonth)) {        
            result.rejectValue(constraint.getPropertyPath().toString(), "empmonth.error." + constraint.getPropertyPath(), constraint.getMessage());            
        }        
        if (result.hasErrors()) {        
            modelMap.addAllAttributes(result.getAllErrors());            
            modelMap.addAttribute("empmonth", empmonth);            
            modelMap.addAttribute("employees", Employee.findAllEmployees());            
            modelMap.addAttribute("_monthstatus", MonthStatus.class.getEnumConstants());            
            return "empmonth/create";            
        }        
        empmonth.persist();        
        return "redirect:/empmonth/" + empmonth.getId();        
    }    
    
    @RequestMapping(value = "/empmonth/form", method = RequestMethod.GET)    
    public String EmpMonthController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("empmonth", new EmpMonth());        
        modelMap.addAttribute("employees", Employee.findAllEmployees());        
        modelMap.addAttribute("_monthstatus", MonthStatus.class.getEnumConstants());        
        return "empmonth/create";        
    }    
    
    @RequestMapping(value = "/empmonth/{id}", method = RequestMethod.GET)    
    public String EmpMonthController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("empmonth", EmpMonth.findEmpMonth(id));        
        return "empmonth/show";        
    }    
    
    @RequestMapping(value = "/empmonth", method = RequestMethod.GET)    
    public String EmpMonthController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("empmonths", EmpMonth.findEmpMonthEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) EmpMonth.countEmpMonths() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("empmonths", EmpMonth.findAllEmpMonths());            
        }        
        return "empmonth/list";        
    }    
    
    @RequestMapping(method = RequestMethod.PUT)    
    public String EmpMonthController.update(@ModelAttribute("empmonth") EmpMonth empmonth, BindingResult result, ModelMap modelMap) {    
        if (empmonth == null) throw new IllegalArgumentException("A empmonth is required");        
        for (ConstraintViolation<EmpMonth> constraint : Validation.buildDefaultValidatorFactory().getValidator().validate(empmonth)) {        
            result.rejectValue(constraint.getPropertyPath().toString(), "empmonth.error." + constraint.getPropertyPath(), constraint.getMessage());            
        }        
        if (result.hasErrors()) {        
            modelMap.addAllAttributes(result.getAllErrors());            
            modelMap.addAttribute("empmonth", empmonth);            
            modelMap.addAttribute("employees", Employee.findAllEmployees());            
            modelMap.addAttribute("_monthstatus", MonthStatus.class.getEnumConstants());            
            return "empmonth/update";            
        }        
        empmonth.merge();        
        return "redirect:/empmonth/" + empmonth.getId();        
    }    
    
    @RequestMapping(value = "/empmonth/{id}/form", method = RequestMethod.GET)    
    public String EmpMonthController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("empmonth", EmpMonth.findEmpMonth(id));        
        modelMap.addAttribute("employees", Employee.findAllEmployees());        
        modelMap.addAttribute("_monthstatus", MonthStatus.class.getEnumConstants());        
        return "empmonth/update";        
    }    
    
    @RequestMapping(value = "/empmonth/{id}", method = RequestMethod.DELETE)    
    public String EmpMonthController.delete(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        EmpMonth.findEmpMonth(id).remove();        
        return "redirect:/empmonth";        
    }    
    
    @RequestMapping(value = "find/ByNumberEquals/form", method = RequestMethod.GET)    
    public String EmpMonthController.findEmpMonthsByNumberEqualsForm(ModelMap modelMap) {    
        return "empmonth/findEmpMonthsByNumberEquals";        
    }    
    
    @RequestMapping(value = "find/ByNumberEquals", method = RequestMethod.GET)    
    public String EmpMonthController.findEmpMonthsByNumberEquals(@RequestParam("number") String number, ModelMap modelMap) {    
        if (number == null || number.length() == 0) throw new IllegalArgumentException("A Number is required.");        
        modelMap.addAttribute("empmonths", EmpMonth.findEmpMonthsByNumberEquals(number).getResultList());        
        return "empmonth/list";        
    }    
    
    @RequestMapping(value = "find/ByEmployeeAndNumberEquals/form", method = RequestMethod.GET)    
    public String EmpMonthController.findEmpMonthsByEmployeeAndNumberEqualsForm(ModelMap modelMap) {    
        modelMap.addAttribute("employees", Employee.findAllEmployees());        
        return "empmonth/findEmpMonthsByEmployeeAndNumberEquals";        
    }    
    
    @RequestMapping(value = "find/ByEmployeeAndNumberEquals", method = RequestMethod.GET)    
    public String EmpMonthController.findEmpMonthsByEmployeeAndNumberEquals(@RequestParam("employee") Employee employee, @RequestParam("number") String number, ModelMap modelMap) {    
        if (employee == null) throw new IllegalArgumentException("A Employee is required.");        
        if (number == null || number.length() == 0) throw new IllegalArgumentException("A Number is required.");        
        modelMap.addAttribute("empmonths", EmpMonth.findEmpMonthsByEmployeeAndNumberEquals(employee, number).getResultList());        
        return "empmonth/list";        
    }    
    
}
