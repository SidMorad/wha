package nl.hajari.wha.web.controller;

import java.lang.Long;
import java.lang.String;
import javax.validation.Valid;
import nl.hajari.wha.domain.Constants;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect ConstantsController_Roo_Controller {
    
    @RequestMapping(value = "/admin/constants", method = RequestMethod.POST)    
    public String ConstantsController.create(@Valid Constants constants, BindingResult result, ModelMap modelMap) {    
        if (constants == null) throw new IllegalArgumentException("A constants is required");        
        if (result.hasErrors()) {        
            return "admin/constants/create";            
        }        
        constants.persist();        
        return "redirect:/admin/constants/" + constants.getId();        
    }    
    
    @RequestMapping(value = "/admin/constants/form", method = RequestMethod.GET)    
    public String ConstantsController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("constants", new Constants());        
        return "admin/constants/create";        
    }    
    
    @RequestMapping(value = "/admin/constants/{id}", method = RequestMethod.GET)    
    public String ConstantsController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("constants", Constants.findConstants(id));        
        return "admin/constants/show";        
    }    
    
    @RequestMapping(value = "/admin/constants", method = RequestMethod.GET)    
    public String ConstantsController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("constantses", Constants.findConstantsEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) Constants.countConstantses() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("constantses", Constants.findAllConstantses());            
        }        
        return "admin/constants/list";        
    }    
    
    @RequestMapping(method = RequestMethod.PUT)    
    public String ConstantsController.update(@Valid Constants constants, BindingResult result, ModelMap modelMap) {    
        if (constants == null) throw new IllegalArgumentException("A constants is required");        
        if (result.hasErrors()) {        
            return "admin/constants/update";            
        }        
        constants.merge();        
        return "redirect:/admin/constants/" + constants.getId();        
    }    
    
    @RequestMapping(value = "/admin/constants/{id}/form", method = RequestMethod.GET)    
    public String ConstantsController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("constants", Constants.findConstants(id));        
        return "admin/constants/update";        
    }    
    
    @RequestMapping(value = "/admin/constants/{id}", method = RequestMethod.DELETE)    
    public String ConstantsController.delete(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        Constants.findConstants(id).remove();        
        return "redirect:/admin/constants";        
    }    
    
}
