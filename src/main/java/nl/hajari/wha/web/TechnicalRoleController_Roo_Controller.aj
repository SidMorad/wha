package nl.hajari.wha.web;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.TechnicalRole;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect TechnicalRoleController_Roo_Controller {
    
    @RequestMapping(value = "/technicalrole", method = RequestMethod.POST)    
    public String TechnicalRoleController.create(@Valid TechnicalRole technicalrole, BindingResult result, ModelMap modelMap) {    
        if (technicalrole == null) throw new IllegalArgumentException("A technicalrole is required");        
        if (result.hasErrors()) {        
            return "technicalrole/create";            
        }        
        technicalrole.persist();        
        return "redirect:/technicalrole/" + technicalrole.getId();        
    }    
    
    @RequestMapping(value = "/technicalrole/form", method = RequestMethod.GET)    
    public String TechnicalRoleController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("technicalrole", new TechnicalRole());        
        return "technicalrole/create";        
    }    
    
    @RequestMapping(value = "/technicalrole/{id}", method = RequestMethod.GET)    
    public String TechnicalRoleController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("technicalrole", TechnicalRole.findTechnicalRole(id));        
        return "technicalrole/show";        
    }    
    
    @RequestMapping(value = "/technicalrole", method = RequestMethod.GET)    
    public String TechnicalRoleController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("technicalroles", TechnicalRole.findTechnicalRoleEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) TechnicalRole.countTechnicalRoles() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("technicalroles", TechnicalRole.findAllTechnicalRoles());            
        }        
        return "technicalrole/list";        
    }    
    
    @RequestMapping(method = RequestMethod.PUT)    
    public String TechnicalRoleController.update(@Valid TechnicalRole technicalrole, BindingResult result, ModelMap modelMap) {    
        if (technicalrole == null) throw new IllegalArgumentException("A technicalrole is required");        
        if (result.hasErrors()) {        
            return "technicalrole/update";            
        }        
        technicalrole.merge();        
        return "redirect:/technicalrole/" + technicalrole.getId();        
    }    
    
    @RequestMapping(value = "/technicalrole/{id}/form", method = RequestMethod.GET)    
    public String TechnicalRoleController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("technicalrole", TechnicalRole.findTechnicalRole(id));        
        return "technicalrole/update";        
    }    
    
    @RequestMapping(value = "/technicalrole/{id}", method = RequestMethod.DELETE)    
    public String TechnicalRoleController.delete(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        TechnicalRole.findTechnicalRole(id).remove();        
        return "redirect:/technicalrole";        
    }    
    
}
