package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.Role;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect RoleController_Roo_Controller {
    
    @RequestMapping(value = "/role", method = RequestMethod.POST)    
    public String RoleController.create(@Valid Role role, BindingResult result, ModelMap modelMap) {    
        if (role == null) throw new IllegalArgumentException("A role is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("role", role);            
            return "role/create";            
        }        
        role.persist();        
        return "redirect:/role/" + role.getId();        
    }    
    
    @RequestMapping(value = "/role/form", method = RequestMethod.GET)    
    public String RoleController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("role", new Role());        
        return "role/create";        
    }    
    
    @RequestMapping(value = "/role/{id}", method = RequestMethod.GET)    
    public String RoleController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("role", Role.findRole(id));        
        return "role/show";        
    }    
    
    @RequestMapping(value = "/role", method = RequestMethod.GET)    
    public String RoleController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("roles", Role.findRoleEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) Role.countRoles() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("roles", Role.findAllRoles());            
        }        
        return "role/list";        
    }    
    
    @RequestMapping(method = RequestMethod.PUT)    
    public String RoleController.update(@Valid Role role, BindingResult result, ModelMap modelMap) {    
        if (role == null) throw new IllegalArgumentException("A role is required");        
        if (result.hasErrors()) {        
            modelMap.addAttribute("role", role);            
            return "role/update";            
        }        
        role.merge();        
        return "redirect:/role/" + role.getId();        
    }    
    
    @RequestMapping(value = "/role/{id}/form", method = RequestMethod.GET)    
    public String RoleController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("role", Role.findRole(id));        
        return "role/update";        
    }    
    
    @RequestMapping(value = "/role/{id}", method = RequestMethod.DELETE)    
    public String RoleController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        Role.findRole(id).remove();        
        return "redirect:/role?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());        
    }    
    
    @RequestMapping(value = "find/ByNameEquals/form", method = RequestMethod.GET)    
    public String RoleController.findRolesByNameEqualsForm(ModelMap modelMap) {    
        return "role/findRolesByNameEquals";        
    }    
    
    @RequestMapping(value = "find/ByNameEquals", method = RequestMethod.GET)    
    public String RoleController.findRolesByNameEquals(@RequestParam("name") String name, ModelMap modelMap) {    
        if (name == null || name.length() == 0) throw new IllegalArgumentException("A Name is required.");        
        modelMap.addAttribute("roles", Role.findRolesByNameEquals(name).getResultList());        
        return "role/list";        
    }    
    
}
