package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.TechRole;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect TechRoleController_Roo_Controller {
    
    @RequestMapping(value = "/techrole", method = RequestMethod.POST)    
    public String TechRoleController.create(@Valid TechRole techrole, BindingResult result, ModelMap modelMap) {    
        if (techrole == null) throw new IllegalArgumentException("A techrole is required");        
        if (result.hasErrors()) {        
            return "techrole/create";            
        }        
        techrole.persist();        
        return "redirect:/techrole/" + techrole.getId();        
    }    
    
    @RequestMapping(value = "/techrole/form", method = RequestMethod.GET)    
    public String TechRoleController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("techrole", new TechRole());        
        return "techrole/create";        
    }    
    
    @RequestMapping(value = "/techrole/{id}", method = RequestMethod.GET)    
    public String TechRoleController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("techrole", TechRole.findTechRole(id));        
        return "techrole/show";        
    }    
    
    @RequestMapping(value = "/techrole", method = RequestMethod.GET)    
    public String TechRoleController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("techroles", TechRole.findTechRoleEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) TechRole.countTechRoles() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("techroles", TechRole.findAllTechRoles());            
        }        
        return "techrole/list";        
    }    
    
    @RequestMapping(method = RequestMethod.PUT)    
    public String TechRoleController.update(@Valid TechRole techrole, BindingResult result, ModelMap modelMap) {    
        if (techrole == null) throw new IllegalArgumentException("A techrole is required");        
        if (result.hasErrors()) {        
            return "techrole/update";            
        }        
        techrole.merge();        
        return "redirect:/techrole/" + techrole.getId();        
    }    
    
    @RequestMapping(value = "/techrole/{id}/form", method = RequestMethod.GET)    
    public String TechRoleController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("techrole", TechRole.findTechRole(id));        
        return "techrole/update";        
    }    
    
    @RequestMapping(value = "/techrole/{id}", method = RequestMethod.DELETE)    
    public String TechRoleController.delete(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        TechRole.findTechRole(id).remove();        
        return "redirect:/techrole";        
    }    
    
}
