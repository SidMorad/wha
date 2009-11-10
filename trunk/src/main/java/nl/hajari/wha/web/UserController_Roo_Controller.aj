package nl.hajari.wha.web;

import java.lang.Long;
import java.lang.String;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import nl.hajari.wha.domain.Employee;
import nl.hajari.wha.domain.Role;
import nl.hajari.wha.domain.User;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

privileged aspect UserController_Roo_Controller {
    
    @RequestMapping(value = "/user", method = RequestMethod.POST)    
    public String UserController.create(@ModelAttribute("user") User user, BindingResult result, ModelMap modelMap) {    
        if (user == null) throw new IllegalArgumentException("A user is required");        
        for (ConstraintViolation<User> constraint : Validation.buildDefaultValidatorFactory().getValidator().validate(user)) {        
            result.rejectValue(constraint.getPropertyPath().toString(), "user.error." + constraint.getPropertyPath(), constraint.getMessage());            
        }        
        if (result.hasErrors()) {        
            modelMap.addAllAttributes(result.getAllErrors());            
            modelMap.addAttribute("user", user);            
            modelMap.addAttribute("employees", Employee.findAllEmployees());            
            modelMap.addAttribute("roles", Role.findAllRoles());            
            return "user/create";            
        }        
        user.persist();        
        return "redirect:/user/" + user.getId();        
    }    
    
    @RequestMapping(value = "/user/form", method = RequestMethod.GET)    
    public String UserController.createForm(ModelMap modelMap) {    
        modelMap.addAttribute("user", new User());        
        modelMap.addAttribute("employees", Employee.findAllEmployees());        
        modelMap.addAttribute("roles", Role.findAllRoles());        
        return "user/create";        
    }    
    
    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET)    
    public String UserController.show(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("user", User.findUser(id));        
        return "user/show";        
    }    
    
    @RequestMapping(value = "/user", method = RequestMethod.GET)    
    public String UserController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, ModelMap modelMap) {    
        if (page != null || size != null) {        
            int sizeNo = size == null ? 10 : size.intValue();            
            modelMap.addAttribute("users", User.findUserEntries(page == null ? 0 : (page.intValue() - 1) * sizeNo, sizeNo));            
            float nrOfPages = (float) User.countUsers() / sizeNo;            
            modelMap.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));            
        } else {        
            modelMap.addAttribute("users", User.findAllUsers());            
        }        
        return "user/list";        
    }    
    
    @RequestMapping(method = RequestMethod.PUT)    
    public String UserController.update(@ModelAttribute("user") User user, BindingResult result, ModelMap modelMap) {    
        if (user == null) throw new IllegalArgumentException("A user is required");        
        for (ConstraintViolation<User> constraint : Validation.buildDefaultValidatorFactory().getValidator().validate(user)) {        
            result.rejectValue(constraint.getPropertyPath().toString(), "user.error." + constraint.getPropertyPath(), constraint.getMessage());            
        }        
        if (result.hasErrors()) {        
            modelMap.addAllAttributes(result.getAllErrors());            
            modelMap.addAttribute("user", user);            
            modelMap.addAttribute("employees", Employee.findAllEmployees());            
            modelMap.addAttribute("roles", Role.findAllRoles());            
            return "user/update";            
        }        
        user.merge();        
        return "redirect:/user/" + user.getId();        
    }    
    
    @RequestMapping(value = "/user/{id}/form", method = RequestMethod.GET)    
    public String UserController.updateForm(@PathVariable("id") Long id, ModelMap modelMap) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        modelMap.addAttribute("user", User.findUser(id));        
        modelMap.addAttribute("employees", Employee.findAllEmployees());        
        modelMap.addAttribute("roles", Role.findAllRoles());        
        return "user/update";        
    }    
    
    @RequestMapping(value = "/user/{id}", method = RequestMethod.DELETE)    
    public String UserController.delete(@PathVariable("id") Long id) {    
        if (id == null) throw new IllegalArgumentException("An Identifier is required");        
        User.findUser(id).remove();        
        return "redirect:/user";        
    }    
    
    @RequestMapping(value = "find/ByUsernameEquals/form", method = RequestMethod.GET)    
    public String UserController.findUsersByUsernameEqualsForm(ModelMap modelMap) {    
        return "user/findUsersByUsernameEquals";        
    }    
    
    @RequestMapping(value = "find/ByUsernameEquals", method = RequestMethod.GET)    
    public String UserController.findUsersByUsernameEquals(@RequestParam("username") String username, ModelMap modelMap) {    
        if (username == null || username.length() == 0) throw new IllegalArgumentException("A Username is required.");        
        modelMap.addAttribute("users", User.findUsersByUsernameEquals(username).getResultList());        
        return "user/list";        
    }    
    
}