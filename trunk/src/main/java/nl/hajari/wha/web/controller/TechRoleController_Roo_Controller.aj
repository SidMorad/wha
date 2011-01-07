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
    public String TechRoleController.create(@Valid TechRole techRole, BindingResult result, ModelMap modelMap) {
        if (techRole == null) throw new IllegalArgumentException("A techRole is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("techRole", techRole);
            return "techrole/create";
        }
        techRole.persist();
        return "redirect:/techrole/" + techRole.getId();
    }
    
    @RequestMapping(value = "/techrole/form", method = RequestMethod.GET)
    public String TechRoleController.createForm(ModelMap modelMap) {
        modelMap.addAttribute("techRole", new TechRole());
        return "techrole/create";
    }
    
    @RequestMapping(value = "/techrole/{id}", method = RequestMethod.GET)
    public String TechRoleController.show(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("techRole", TechRole.findTechRole(id));
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
    public String TechRoleController.update(@Valid TechRole techRole, BindingResult result, ModelMap modelMap) {
        if (techRole == null) throw new IllegalArgumentException("A techRole is required");
        if (result.hasErrors()) {
            modelMap.addAttribute("techRole", techRole);
            return "techrole/update";
        }
        techRole.merge();
        return "redirect:/techrole/" + techRole.getId();
    }
    
    @RequestMapping(value = "/techrole/{id}/form", method = RequestMethod.GET)
    public String TechRoleController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        modelMap.addAttribute("techRole", TechRole.findTechRole(id));
        return "techrole/update";
    }
    
    @RequestMapping(value = "/techrole/{id}", method = RequestMethod.DELETE)
    public String TechRoleController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size) {
        if (id == null) throw new IllegalArgumentException("An Identifier is required");
        TechRole.findTechRole(id).remove();
        return "redirect:/techrole?page=" + ((page == null) ? "1" : page.toString()) + "&size=" + ((size == null) ? "10" : size.toString());
    }
    
}
