package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.Customer;
import nl.hajari.wha.domain.Project;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect ProjectController_Roo_Controller {
    
    @RequestMapping(value = "/project", method = RequestMethod.POST)
    public String ProjectController.create(@Valid Project project, BindingResult result, ModelMap modelMap) {
        if (project == null) throw new IllegalArgumentException("A project is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("project", project);
            modelMap.addAttribute("customers", Customer.findAllCustomers());
            return "project/create";
        }
        project.persist();
        return "redirect:/project/" + project.getId();
    }
    
    @RequestMapping(value = "/project/form", method = RequestMethod.GET)
    public String ProjectController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("project", new Project());
        modelMap.addAttribute("customers", Customer.findAllCustomers());
        return "project/create";
    }
    
    @RequestMapping(value = "/project/{id}", method = RequestMethod.GET)
    public String ProjectController.show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("project", Project.findProject(id));
        return "project/show";
    }
    
    @RequestMapping(value = "/project", method = RequestMethod.GET)
    public String ProjectController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            modelMap.addAttribute("projects", Project.findProjectEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));
            float nrOfPages = (float) Project.countProjects() / sizeNo;
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            modelMap.addAttribute("projects", Project.findAllProjects());
        }
        return "project/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT)
    public String ProjectController.update(@Valid Project project, BindingResult result, ModelMap modelMap) {
        if (project == null) throw new IllegalArgumentException("A project is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("project", project);
            modelMap.addAttribute("customers", Customer.findAllCustomers());
            return "project/update";
        }
        project.merge();
        return "redirect:/project/" + project.getId();
    }
    
    @RequestMapping(value = "/project/{id}/form", method = RequestMethod.GET)
    public String ProjectController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("project", Project.findProject(id));
        modelMap.addAttribute("customers", Customer.findAllCustomers());
        return "project/update";
    }
    
    @RequestMapping(value = "/project/{id}", method = RequestMethod.DELETE)
    public String ProjectController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        Project.findProject(id).remove();
        return "redirect:/project?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
    @RequestMapping(value = "find/ByNameEquals/form", method = RequestMethod.GET)
    public String ProjectController.findProjectsByNameEqualsForm(ModelMap modelMap) {
        return "project/findProjectsByNameEquals";
    }
    
    @RequestMapping(value = "find/ByNameEquals", method = RequestMethod.GET)
    public String ProjectController.findProjectsByNameEquals(@RequestParam("name") String name, ModelMap modelMap) {
        if (name == null || name.length() == 0) throw new IllegalArgumentException("A Name is required.");
        modelMap.addAttribute("projects", Project.findProjectsByNameEquals(name).getResultList());
        return "project/list";
    }
    
    @RequestMapping(value = "find/ByNameLike/form", method = RequestMethod.GET)
    public String ProjectController.findProjectsByNameLikeForm(ModelMap modelMap) {
        return "project/findProjectsByNameLike";
    }
    
    @RequestMapping(value = "find/ByNameLike", method = RequestMethod.GET)
    public String ProjectController.findProjectsByNameLike(@RequestParam("name") String name, ModelMap modelMap) {
        if (name == null || name.length() == 0) throw new IllegalArgumentException("A Name is required.");
        modelMap.addAttribute("projects", Project.findProjectsByNameLike(name).getResultList());
        return "project/list";
    }
    
    @RequestMapping(value = "find/ByCustomerAndNameEquals/form", method = RequestMethod.GET)
    public String ProjectController.findProjectsByCustomerAndNameEqualsForm(ModelMap modelMap) {
        modelMap.addAttribute("customers", Customer.findAllCustomers());
        return "project/findProjectsByCustomerAndNameEquals";
    }
    
    @RequestMapping(value = "find/ByCustomerAndNameEquals", method = RequestMethod.GET)
    public String ProjectController.findProjectsByCustomerAndNameEquals(@RequestParam("customer") Customer customer, @RequestParam("name") String name, ModelMap modelMap) {
        if (customer == null) throw new IllegalArgumentException("A Customer is required.");
        if (name == null || name.length() == 0) throw new IllegalArgumentException("A Name is required.");
        modelMap.addAttribute("projects", Project.findProjectsByCustomerAndNameEquals(customer, name).getResultList());
        return "project/list";
    }
    
}
