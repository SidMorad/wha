package nl.hajari.wha.web.controller;

import javax.validation.Valid;

import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.EmployeeConstants;
import nl.hajari.wha.web.controller.formbean.EmployeeConstantsFilterFormBean;

import org.springframework.roo.addon.web.mvc.controller.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@RooWebScaffold(path = "admin/emp_cons", automaticallyMaintainView = false, formBackingObject = EmployeeConstants.class)
@RequestMapping("/admin/emp_cons/**")
@Controller
public class EmployeeConstantsController extends AbstractController {
	
    @RequestMapping(value = "/admin/emp_cons", method = RequestMethod.GET)
    public String list(@RequestParam(value = "page", required = false) Integer page, 
    				   @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            modelMap.addAttribute("employeeconstantses", EmployeeConstants.findEmployeeConstantsEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) EmployeeConstants.countEmployeeConstantses() / sizeNo;
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            modelMap.addAttribute("employeeconstantses", EmployeeConstants.findAllEmployeeConstantses());
        }
        modelMap.addAttribute("employeeConstantsFilterFormBean", new EmployeeConstantsFilterFormBean());
        modelMap.addAttribute("employees", Employee.findAllEmployees());
        return "admin/emp_cons/list";
    }
    
    @RequestMapping(value = "/admin/emp_cons/filter", method = RequestMethod.POST)
    public String filter(@Valid EmployeeConstantsFilterFormBean formBean, ModelMap modelMap) {
    	logger.debug("Selected Employee was :" + formBean.getEmployee());
    	modelMap.addAttribute("employeeconstantses", EmployeeConstants.findEmployeeConstantsesByEmployee(formBean.getEmployee()).getResultList());    	
    	modelMap.addAttribute("employeeConstantsFilterFormBean", formBean);
    	modelMap.addAttribute("employees", Employee.findAllEmployees());
    	return "admin/emp_cons/list";
    }

}